class Visit < ActiveRecord::Base
  belongs_to :customer
  belongs_to :product_area
end
