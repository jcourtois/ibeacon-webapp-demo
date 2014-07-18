class ChangeIdsToInt < ActiveRecord::Migration
  def up
    if Rails.env == 'production'
      change_column :coupons, :product_area_id, 'integer USING CAST(product_area_id AS integer)'
      change_column :events, :coupon_id, 'integer USING CAST(coupon_id AS integer)'
    else
      change_column :coupons, :product_area_id, :int
      change_column :events, :coupon_id, :int
    end
  end
  def down
    change_column :coupons, :product_area_id, :string
    change_column :events, :coupon_id, :string
  end
end
