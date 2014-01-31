class CreateProductAreas < ActiveRecord::Migration
  def change
    create_table :product_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
