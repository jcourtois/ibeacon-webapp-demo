class Customer < ActiveRecord::Base
  has_many :visits

  def to_s
    "Member number #{membership_number}"
  end
end
