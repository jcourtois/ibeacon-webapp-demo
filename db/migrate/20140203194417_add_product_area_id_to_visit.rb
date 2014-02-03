class AddProductAreaIdToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :product_area_id, :integer
  end
end
