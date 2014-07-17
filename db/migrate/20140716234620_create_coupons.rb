class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :product_area_id
    end
  end
end
