require 'spec_helper'

describe Customer do

  it 'has a valid factory' do
    FactoryGirl.build(:customer).valid?.should == true
  end
end