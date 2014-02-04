class Customer < ActiveRecord::Base
  validates_uniqueness_of :membership_number

  has_many :visits

  def to_param
    membership_number
  end

end
