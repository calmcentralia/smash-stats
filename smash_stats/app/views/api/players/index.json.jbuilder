
json.array!(@players) do |player|
  json.skill player.skill
  json.tag player.names.first.tag
  json.confidence_low player.skill - (player.rating_deviation*2)
  json.confidence_high player.skill + (player.rating_deviation*2)
end
