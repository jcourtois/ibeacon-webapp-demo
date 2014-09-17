module VisitsHelper
  def total_duration visits
    Time.at(visits.map{ |visit| visit.duration }.reduce(:+)).utc.strftime("%H:%M:%S").gsub(/^[0:]*/, '')
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

  def coupons_map
    {
        'Dairy' => {name: 'Chobani Yogurt', description: '4/$6', legal: 'Limit 4 per customer'},
        'Soup' => {name: 'Campbell\'s Soup', description: '2/$5', legal: '14 oz size or larger'},
        'Salad Dressing' => {name: 'Wish-bone Salad Dressing', description: '$3.29', legal: 'Fat free varieties'},
        'Pet Food' => {name: 'Friskies Cat Food', description: 'BOGO 50% Off', legal: 'Limit 4 per customer'},
        'Crackers' => {name: 'Nabisco Crackers', description: '$2.33', legal: 'When you buy 2'}
    }
  end

  def coupons_image_map
    {
        'Dairy' => 'chobani.jpg',
        'Soup' => 'campbells.jpg',
        'Salad Dressing' => 'wishbone.jpg',
        'Pet Food' => 'friskies.jpg',
        'Crackers' => 'nabisco.jpg'
    }
  end

  def coupon_event(coupon_name, clicked_coupons)
    clicked_coupons.map(&:name).include?(coupon_name) ? 'clicked' : 'delivered'
  end
end
