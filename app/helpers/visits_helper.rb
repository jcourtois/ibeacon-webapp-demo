module VisitsHelper
  def total_duration visits
    Time.at(visits.flat_map{|visit| visit.duration}.reduce(:+)).utc.strftime("%H:%M:%S").gsub(/^[0:]*/, '')
  end
end
