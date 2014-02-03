class AddMembershipNumberToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :membership_number, :integer
  end
end
