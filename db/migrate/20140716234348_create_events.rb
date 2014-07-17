class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :customer_id
      t.string :event_type
      t.datetime :time
      t.string :coupon_id
      t.timestamps
    end
  end
end
