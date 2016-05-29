json.array!(@tournaments) do |tournament|
  json.title tournament.title
  json.updated_at tournament.updated_at
  json.event_time tournament.event_time
end
