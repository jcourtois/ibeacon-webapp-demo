class Visit < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :customer
  belongs_to :product_area

  def exit_time_or_ongoing
    exit_time || Time.now - 6.hours
  end

  def duration
    exit_time_or_ongoing - enter_time
  end

  def string_numeric_duration
    Time.at(duration).utc.strftime("%H:%M:%S").gsub(/^00:0|^00:|^0/, '')
  end

  def verbal_duration
    if exit_time
      distance_of_time_in_words(exit_time, enter_time, include_seconds: true)
    else
      distance_of_time_in_words_to_now(enter_time, include_seconds: true)
    end
  end

  def to_pie_chart_json
    {"value" => duration, "color" => product_area.color}
  end

  def to_step_graph_times position
    position == 'enter' ? enter_time.to_i * 1000 : exit_time.to_i * 1000
  end

  def to_step_graph_product_areas
    product_area.id
  end

  def to_step_graph_labels
    [product_area.id, product_area.name]
	end

	def formatted_enter_time
    enter_time.strftime("%l:%M%P").strip
  end

  def formatted_exit_time
    exit_time ? exit_time.strftime("%l:%M%P").strip : '----'
  end
end
