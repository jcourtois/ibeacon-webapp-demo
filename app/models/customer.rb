class Customer < ActiveRecord::Base
  validates_uniqueness_of :membership_number

  has_many :visits

  def to_param
    membership_number
  end

  def smoothed_visits
    collapse_consecutive_visits_to_same_area(long_visits_from visits)
  end


  private

  def long_visits_from visits
    visits.keep_if{|visit| visit.duration > 5.0 }
  end

  def collapse_consecutive_visits_to_same_area visits
    visits
    .chunk{ |visit| visit.product_area }
    .flat_map do |same_area, array_of_visits|
      Visit.new(
          customer_id: self.id,
          enter_time: earliest_visit_enter_time(array_of_visits),
          exit_time: latest_visit_exit_time(array_of_visits),
          product_area: same_area)
    end
  end

  def earliest_visit_enter_time visits
    visits.min_by{|visit| visit.enter_time}.enter_time
  end

  def latest_visit_exit_time visits
    visits.max_by{|visit| visit.exit_time}.exit_time
  end

end
