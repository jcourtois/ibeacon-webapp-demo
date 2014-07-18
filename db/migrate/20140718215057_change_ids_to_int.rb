class ChangeIdsToInt < ActiveRecord::Migration
  def up
    change_column :coupons, :product_area_id, :int
    change_column :events, :coupon_id, :int
  end
  def down
    change_column :coupons, :product_area_id, :string
    change_column :events, :coupon_id, :string
  end
end
