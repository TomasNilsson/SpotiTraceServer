json.array! @nearby_locations do |location|
  user = location.user
  json.id user.id
  json.username user.username
  json.distance location.distance
  json.bearing location.bearing

  song = user.song
  json.song do
    json.name song.name
    json.artist song.artist
    json.uri song.uri
    json.image_url song.image_url
  end
end
