class Customer < ActiveRecord::Base
  validates_uniqueness_of :membership_number
  has_many :visits
  has_many :events
  has_many :click_events, -> { where(event_type: Event::CLICK)}, class_name: 'Event'

  def to_param
    membership_number
  end

  def smoothed_visits
    @smoothed_visits ||= collapse_consecutive_visits_to_same_area(long_visits_from visits)
  end

  def sorted_smoothed_visits
    smoothed_visits.sort_by { |visit| visit.enter_time}
  end

  def clicked_coupons
    click_events.includes(:coupon).map(&:coupon)
  end

  def product_areas_visited
    visits.order(:enter_time).map(&:product_area).uniq
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
    visits.map{|visit| visit.enter_time}.min
  end

  def latest_visit_exit_time visits
    visits.map{|visit| visit.exit_time_or_ongoing }.max
  end
end
