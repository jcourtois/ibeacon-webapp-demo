class ProductArea < ActiveRecord::Base
  has_many :visits

  def color
    area_colors[name]
  end

  private
  def area_colors
    color_hash = {
        "Grains" => "#FFD772",
        "Produce" => "#3CE85F",
        "Dairy" => "#F9FAFF",
        "Meat" => "#E8362B",
        "Non-perishables" => "#FFDC05",
        "Dog food" => "#5E301C",
        "Wine Cellar" => "#870F00"
    }
    color_hash.default="#999999"
    color_hash
  end
end
