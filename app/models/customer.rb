class Customer < ActiveRecord::Base
  has_many :visits
end
