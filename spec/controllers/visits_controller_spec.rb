require 'spec_helper'

describe VisitsController do
  describe '#create' do
    context 'with json request' do
      let(:request_data) { JSON.parse(File.read('spec/fixtures/wine_cellar_visit_request.json')) }
      let(:request_entry_time) { DateTime.parse(request_data['visit']['enter_time']) }
      let(:request_exit_time) { DateTime.parse(request_data['visit']['exit_time']) }
      let(:request_membership_number) { request_data['membership_number'].gsub(/\D/, '') }

      it 'creates a new visit, a new customer, and a new product area' do
        post :create, request_data, use_route: :visits_new

        customer = Customer.find_by(membership_number: request_membership_number)
        customer.should_not be_nil
        customer.visits.where(
          enter_time: request_entry_time,
          exit_time: request_exit_time
        ).should exist

        ProductArea.find_by(name: 'Wine Cellar').should_not be_nil
      end

      it 'creates a second visit, using an existing customer, and an existing product area' do
        FactoryGirl.create(:dairy_visit)

        post :create, request_data, use_route: :visits_new

        customer = Customer.find_by(membership_number: request_membership_number)
        customer.visits.where(
          enter_time: request_entry_time,
          exit_time: request_exit_time
        ).should exist

        ProductArea.find_by(name: 'Wine Cellar').should_not be_nil
      end
    end
  end
end