class Visit < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :customer
  belongs_to :product_area

  def duration
    exit_time - enter_time
  end

  def verbal_duration
    if exit_time
      distance_of_time_in_words(exit_time, enter_time, include_seconds: true)
    else
      distance_of_time_in_words_to_now(enter_time, include_seconds: true)
    end
  end

  def to_pie_chart_json
    {"value" => duration, "product_area" => product_area.name}
  end
end
