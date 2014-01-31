json.array!(@visits) do |visit|
  json.extract! visit, :id, :enter_time, :exit_time
  json.url visit_url(visit, format: :json)
end
