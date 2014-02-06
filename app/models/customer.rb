class Customer < ActiveRecord::Base
  validates_uniqueness_of :membership_number

  has_many :visits

  def to_param
    membership_number
  end

  def smoothed_visits
    collapse_consecutive_visits_to_same_area(long_visits_from visits)
  end

  def step_graph_visit_data
    visit_times = step_graph_visit_times(smoothed_visits)
    visit_product_areas = step_graph_visit_product_areas(smoothed_visits)
    visit_times.zip(visit_product_areas)
  end

  def step_graph_label_data
    smoothed_visits.map{|visit| visit.to_step_graph_labels}
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

  def step_graph_visit_times visits
    visit_times = []
    visits.map do |visit|
      visit_times << visit.to_step_graph_times('enter')
      visit_times << visit.to_step_graph_times('exit')
    end
    visit_times
  end

  def step_graph_visit_product_areas visits
    visit_product_areas = []
    visits.map do |visit|
      visit_product_areas << visit.to_step_graph_product_areas
      visit_product_areas << visit.to_step_graph_product_areas
    end
    visit_product_areas
  end
end
