class Event < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :customer

  TYPES = [
    CLICK ='click'
  ]

end
