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

  def unique_areas visits
    visits.map{ |visit| visit.product_area }.uniq
  end

  def coupons_map
    {
        'Yogurt' => 'Chobani',
        'Condiments and sauces' => 'Campbell\'s',
        'Salad dressings and mayonnaise' => 'Wish-bone',
        'Pet food and pet products' => 'Friskies',
        'Crackers, cookies and bread' => 'Nabisco'
    }
  end

  def coupons_image_map
    {
        'Yogurt' => 'chobani.jpg',
        'Condiments and sauces' => 'campbells.jpg',
        'Salad dressings and mayonnaise' => 'wishbone.jpg',
        'Pet food and pet products' => 'friskies.jpg',
        'Crackers, cookies and bread' => 'nabisco.jpg'
    }
  end
end
