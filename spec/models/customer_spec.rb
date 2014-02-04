require 'spec_helper'

describe Customer do

  it 'has a valid factory' do
    FactoryGirl.build(:customer).valid?.should == true
  end

  it 'has parsed the string representation of membership number to integer' do
    FactoryGirl.create(:customer, membership_number: '1 (312) 323-5436')
    Customer.first.membership_number.should == '13123235436'
  end
end