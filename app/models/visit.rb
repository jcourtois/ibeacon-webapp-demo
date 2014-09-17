class Visit < ActiveRecord::Base
  belongs_to :customer
  belongs_to :product_area

  def duration
    exit_time_or_ongoing - enter_time
  end

  def exit_time_or_ongoing
    exit_time || Time.now - 6.hours + 1.second
  end

  def string_numeric_duration
    Time.at(duration).utc.strftime("%H:%M:%S").gsub(/^00:0|^00:|^0/, '')
  end

  def to_pie_chart_json
    {"value" => duration, "color" => product_area.color }
  end

	def formatted_enter_time
    enter_time.strftime("%l:%M%P").strip
  end

  def formatted_exit_time
    exit_time ? exit_time.strftime("%l:%M%P").strip : '----'
  end
end
