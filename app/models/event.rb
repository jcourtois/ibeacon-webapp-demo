class Event < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :customer

end
