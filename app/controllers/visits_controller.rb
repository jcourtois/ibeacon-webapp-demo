class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :destroy]
  before_action :set_customer, except: [:create, :update]
  before_action :set_smoothed_visits, only: [:index, :pie_chart_data, :visit_table]
  skip_before_filter :verify_authenticity_token, only: [:create, :new, :update]

  def index
  end

  def show
  end

  def new
    @visit = Visit.new
  end

  def edit
  end

  def create
    membership_number = params[:membership_number] || params[:customer_id]
    @customer = Customer.find_or_create_by(membership_number: membership_number)
    @product_area = ProductArea.find_or_create_by(name: params['visit']['product_area'])
    @visit = Visit.new(visit_params.merge(customer_id: @customer.id, product_area_id: @product_area.id))

    respond_to do |format|
      if @visit.save
        format.html { redirect_to customer_visits_path(@customer), notice: 'Visit was successfully created.' }
        format.json { render action: 'show', status: :created, location: customer_visits_path(@customer) }
      else
        format.html { render action: 'new' }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    membership_number = params[:membership_number] || params[:customer_id]
    @customer = Customer.find_or_create_by(membership_number: membership_number)
    @product_area = ProductArea.find_by(name: params['visit']['product_area'])
    @visit = @customer.visits.find_by(product_area: @product_area, exit_time: nil)

    respond_to do |format|
      if @visit.update(visit_params.merge(customer_id: @customer.id))
        format.html { redirect_to customer_visits_path(@customer), notice: 'Visit was successfully updated.' }
        format.json { render action: 'show', status: :created, location: customer_visits_path(@customer) }
      else
        format.html { render action: 'edit' }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to customer_visits_path }
      format.json { head :no_content }
    end
  end

  def coupons_served_up
    respond_to do |format|
      format.html{ render partial: 'coupons_served_up', locals: {product_areas_visited: @customer.product_areas_visited} }
    end
  end

  def pie_chart_data
    data = @smoothed_visits.map{|visit| visit.to_pie_chart_json}
    respond_to do |format|
      format.json {render json: data}
    end
  end

  def visit_table
    respond_to do |format|
      format.html{ render partial: 'visit_table', locals: {visits: @smoothed_visits} }
    end
  end

  def activity
    new_visit_count = @customer.visits.count
    respond_to do |format|
      format.json {render json: {visit_count: new_visit_count} }
    end
  end


  private
    def set_smoothed_visits
      @smoothed_visits = @customer.sorted_smoothed_visits
    end

    def set_visit
      @visit = Visit.find(params[:id])
    end

    def visit_params
      params.require(:visit).permit(:enter_time, :exit_time)
    end

    def set_customer
      @customer = Customer.where(membership_number: params[:customer_id]).first
    end
end
