class Customer < ActiveRecord::Base
  has_many :visits

  def to_s
    "Customer #{id}"
  end
end
