require 'spec_helper'
require 'yaml'

describe Customer do

  it 'has a valid factory' do
    FactoryGirl.build(:customer).valid?.should == true
  end

  describe '#smoothed_visits' do
    before :each do
      this_time = Time.now
      meats = FactoryGirl.create(:product_area, name:'Meats')
      dairy = FactoryGirl.create(:product_area, name: 'Dairy')
      nuts = FactoryGirl.create(:product_area, name: 'Nuts')

      @time = [20, 2, 45, 20, 12].map{ |t| this_time + t; this_time = this_time + t}

      @customer = FactoryGirl.create(:customer)

      visits = [
          FactoryGirl.create(:visit, :product_area => meats, :enter_time => @time[0], :exit_time => @time[1], :customer => @customer),
          FactoryGirl.create(:visit, :product_area => dairy, :enter_time => @time[1], :exit_time => @time[2], :customer => @customer),
          FactoryGirl.create(:visit, :product_area => meats, :enter_time => @time[2], :exit_time => @time[3], :customer => @customer),
          FactoryGirl.create(:visit, :product_area => meats, :enter_time => @time[3], :exit_time => @time[4], :customer => @customer)
      ]
    end

    context 'when a visit lasts under 5 seconds' do
      it 'should remove the short visit' do
        long_visits = @customer.send :long_visits_from, @customer.visits
        long_visits.count.should eql(3)
        long_visits.all?{|visit| visit.duration > 5.0 }.should be_true
      end
    end

    context 'when there is a list of visits' do
      it 'should return the earliest enter time' do
        earliest_enter_time = @customer.send :earliest_visit_enter_time, @customer.visits
        earliest_enter_time.should eql(@time[0])
      end

      it 'should return the latest exit time' do
        latest_exit_time = @customer.send :latest_visit_exit_time, @customer.visits
        latest_exit_time.should eql(@time[4])
      end
    end

    context 'when we have consecutive visits to the same area' do
      let(:collapsed_visits){ @customer.send :collapse_consecutive_visits_to_same_area, @customer.visits }
      let(:meats) { ProductArea.find_by(name: 'Meats') }
      let(:dairy) { ProductArea.find_by(name: 'Dairy') }

      it 'should have three visits' do
        collapsed_visits.count.should eql(3)
      end

      it 'should have the enter time of the earliest visit' do
        collapsed_visits[0].enter_time.should eql(@time[0])
         collapsed_visits[1].enter_time.should eql(@time[1])
         collapsed_visits[2].enter_time.should eql(@time[2])
      end

      it 'should have the exit time of the latest visit' do
        collapsed_visits[0].exit_time.should eql(@time[1])
        collapsed_visits[1].exit_time.should eql(@time[2])
        collapsed_visits[2].exit_time.should eql(@time[4])
      end

      it 'should have the shared product area' do
        collapsed_visits[0].product_area.should eql(meats)
        collapsed_visits[1].product_area.should eql(dairy)
        collapsed_visits[2].product_area.should eql(meats)
      end

      it 'should have the shared customer id' do
        collapsed_visits.all?{|visit| visit.customer.id.eql?(1)}.should be_true
      end
    end
  end
end