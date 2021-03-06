json.array! @nearby_locations do |location|
  nearby_user = location.user
  json.id nearby_user.id
  json.username nearby_user.username
  json.distance @my_location.distance_to(location)
  json.bearing @my_location.bearing_to(location)
  json.friend @user.friends.exists?(nearby_user)

  song = nearby_user.song
  json.song do
    json.name song.name
    json.artist song.artist
    json.uri song.uri
    json.image_url song.image_url
  end
end
