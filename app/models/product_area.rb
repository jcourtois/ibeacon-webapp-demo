class ProductArea < ActiveRecord::Base
  has_many :visits

  def color
    area_colors[name]
  end

  def css_id
    area_css_ids[name]
  end

  private
  def area_colors
    color_hash = {
        'Grains' => '#FFD772',
        'Produce' => '#3CE85F',
        'Meat' => '#E8362B',
        'Non-perishables' => '#FFDC05',
        'Dog food' => '#5E301C',
        'Wine Cellar' => '#870F00',
        'Canned MeatLike Products' => '#8DFFC9',
        'Fruit' => '#97D700',
        'Drinks' => '#FF7D00',
        'Dairy' => '#A0C9E8',
        'Soup' => '#42968F',
        'Salad Dressing' => '#005B7C',
        'Pet Food' => '#563E3B',
        'Pet food and pet products' => '#563E3B'
    }
    color_hash.default='#999999'
    color_hash
  end

  def area_css_ids
    css_id_hash = {
        'Dairy' => 'dairy',
        'Soup' => 'soup',
        'Salad Dressing' => 'salad',
        'Pet Food' => 'pet',
        'Crackers' => 'crackers'
    }
  end
end
