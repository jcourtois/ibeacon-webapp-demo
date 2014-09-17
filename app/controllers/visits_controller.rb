class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :destroy]
  before_action :set_customer, except: [:create, :update]
  skip_before_filter :verify_authenticity_token, only: [:create, :new, :update]

  def index
    @visits = @customer.visits.sort_by { |visit| visit.enter_time}
    @clicked_coupons = @customer.clicked_coupons
    @smoothed_visits = @customer.smoothed_visits.sort_by { |visit| visit.enter_time}
  end

  def show
  end

  def new
    @visit = Visit.new
  end

  def edit
  end

  def create
    if params[:membership_number]
      @customer = Customer.find_or_create_by(membership_number: params[:membership_number])
    else
      @customer = Customer.find_or_create_by(id: params[:customer_id])
    end
    @product_area = ProductArea.find_or_create_by(name: params['visit']['product_area'])
    @visit = Visit.new(visit_params.merge(customer_id: @customer.id, product_area_id: @product_area.id))

    respond_to do |format|
      if @visit.save
        format.html { redirect_to customer_visits_path(@customer.id), notice: 'Visit was successfully created.' }
        format.json { render action: 'show', status: :created, location: customer_visits_path(@customer) }
      else
        format.html { render action: 'new' }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:membership_number]
      @customer = Customer.find_by(membership_number: params[:membership_number])
    else
      @customer = Customer.find_by(id: params[:customer_id])
    end
    @product_area = ProductArea.find_by(name: params['visit']['product_area'])
    @visit = @customer.visits.find_by(product_area: @product_area, exit_time: nil)

    respond_to do |format|
      if @visit.update(visit_params)
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


  private
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def visit_params
      params.require(:visit).permit(:enter_time, :exit_time, :customer_id)
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
end
