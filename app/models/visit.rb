class Visit < ActiveRecord::Base
  belongs_to :customer
  belongs_to :product_area

  include ActionView::Helpers::DateHelper
  def duration
    exit_time ? distance_of_time_in_words(exit_time, enter_time, include_seconds: true).humanize : 'Ongoing'
  end
end
