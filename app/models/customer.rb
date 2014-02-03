class Customer < ActiveRecord::Base
  has_many :visits

  include ActionView::Helpers::NumberHelper

  def to_s
    "Member number #{number_to_phone(membership_number, area_code: true)}"
  end
end
