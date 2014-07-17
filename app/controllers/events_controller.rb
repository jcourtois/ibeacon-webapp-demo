class EventsController < ApplicationController
  before_filter :find_customer
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    event_params = params[:event]
    coupon = find_coupon(event_params[:coupon])

    event_attributes = event_params.permit(:event_type, :time)
    event_attributes.merge!(customer_id: @customer.id, coupon_id: coupon.id)
    Event.create(event_attributes)

    render :json => {status: :created}.to_json
  end

  private

  def find_customer
    @customer = Customer.where(membership_number: params[:membership_number]).first_or_create
  end

  def find_coupon(coupon_params)
    product_area = ProductArea.where(name: coupon_params[:product_area]).first_or_create

    coupon_attributes = {name: coupon_params[:product_name], description: coupon_params[:description], product_area_id: product_area.id}
    Coupon.where(coupon_attributes).first_or_create
  end
end
