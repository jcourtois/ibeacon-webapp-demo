require 'spec_helper'

describe EventsController do

  let(:event_time) {1.day.ago}
  let(:customer) {create(:customer)}
  let(:product_area) {create(:product_area, name: 'Dairy')}
  let(:coupon) {create(:coupon, name: 'Chobani', description: '$5.00 off', product_area: product_area)}
  let(:event_request) do
    {
      membership_number: customer.membership_number,
      event: {
        event_type: 'click',
        coupon: {
          product_name: coupon.name,
          description: coupon.description,
          product_area: product_area.name
        },
        time: event_time
      }
    }
  end

  describe "#create" do
    it "creates a new event with existing associations" do
      post :create, event_request
      event = Event.last
      expect(event.customer).to eq(customer)
      expect(event.event_type).to eq('click')
      expect(event.time.to_i).to eq(event_time.to_i)
      expect(event.coupon).to eq(coupon)
      expect(event.coupon.product_area).to eq(product_area)
    end

    it "creates a new event with new coupon and product area" do
      event_request[:event].merge!(
        coupon: {
          product_name: 'Chex Mix',
          description: '$2.00 off',
          product_area: 'Snacks'
        })
      post :create, event_request
      event = Event.last
      expect(event.coupon.name).to eq('Chex Mix')
      expect(event.coupon.description).to eq('$2.00 off')
      expect(event.coupon.product_area.name).to eq('Snacks')
    end

    it "creates a new event with new customer" do
      event_request.merge!(
        membership_number: '555',
      )
      post :create, event_request
      event = Event.last
      expect(event.customer.membership_number).to eq('555')
    end
  end

end
