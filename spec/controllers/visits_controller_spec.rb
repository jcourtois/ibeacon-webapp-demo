require 'spec_helper'

describe VisitsController do
  describe '#create' do
    context 'with json request' do
      let(:request_entry_data) { JSON.parse(File.read('spec/fixtures/wine_cellar_visit_entry_request.json')) }
      let(:request_entry_time) { DateTime.parse(request_entry_data['visit']['enter_time']) }
      let(:request_membership_number) { request_entry_data['membership_number'].gsub(/\D/, '') }

      it 'creates a new visit, a new customer, and a new product area' do
        post :create, request_entry_data, use_route: :visits_create

        customer = Customer.find_by(membership_number: request_membership_number)
        customer.should_not be_nil
        customer.visits.where(
          enter_time: request_entry_time,
        ).should exist

        ProductArea.find_by(name: 'Wine Cellar').should_not be_nil
      end

      it 'creates a second visit, using an existing customer, and an existing product area' do
        FactoryGirl.create(:dairy_entry_visit)

        post :create, request_entry_data, use_route: :visits_create

        customer = Customer.find_by(membership_number: request_membership_number)
        customer.visits.where(
          enter_time: request_entry_time,
        ).should exist

        ProductArea.find_by(name: 'Wine Cellar').should_not be_nil
      end
    end
  end

  describe '#update' do
    context 'with exit time' do
      let(:request_exit_data) { JSON.parse(File.read('spec/fixtures/wine_cellar_visit_exit_request.json')) }
      let(:request_exit_time) { DateTime.parse(request_exit_data['visit']['exit_time']) }
      let(:request_membership_number) { request_exit_data['membership_number'].gsub(/\D/, '') }

      it 'stores exit time in the existing visit' do
        factory_customer = FactoryGirl.create(:customer, membership_number: request_membership_number)
        entry_visit = FactoryGirl.create(:wine_cellar_entry_visit, customer: factory_customer)

        patch :update, request_exit_data, use_route: :visits_update

        customer = Customer.find_by(membership_number: request_membership_number)
        customer.visits.where(
          enter_time: entry_visit[:enter_time],
          exit_time: request_exit_time,
        ).should exist
      end
    end
  end
end