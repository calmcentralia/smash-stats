json.array!(@tournaments) do |tournament|
  json.title tournament.title
  json.event_time tournament.event_time
end
