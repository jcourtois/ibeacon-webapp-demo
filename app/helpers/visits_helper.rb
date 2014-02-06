module VisitsHelper
  def total_duration visits
    Time.at(visits.map{ |visit| visit.duration }.reduce(:+)).utc.strftime("%H:%M:%S").gsub(/^[0:]*/, '')
  end

  def pie_chart_data visits
    visits.map{|visit| visit.to_pie_chart_json}
  end

  def step_graph_format time
    time.to_i * 1000
  end

  def step_graph_data visits
    x_axis = visits.flat_map { |visit| [step_graph_format(visit.enter_time), step_graph_format(visit.exit_time)] }
    y_axis = visits.flat_map { |visit| [visit.product_area.id, visit.product_area.id] }
    x_axis.zip(y_axis)
  end

  def step_graph_labels visits
    visits.map{ |visit| [visit.product_area.id, visit.product_area.name] }.uniq
  end
end
