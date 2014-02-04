class ChangeMembershipNumberToStringType < ActiveRecord::Migration
  def self.up
    change_column :customers, :membership_number, :string
  end

  def self.down
    change_column :customers, :membership_number, :integer
  end
end
