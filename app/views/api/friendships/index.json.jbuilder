json.array! @friends do |friend|
  location = @user.location
  
  json.user do
    json.id friend.id
    json.username friend.username
    if !location.blank?
      json.distance location.distance_to(friend.location)
      json.bearing location.bearing_to(friend.location)
    end
  end
  
  song = friend.song

  if !song.blank?
    json.song do
      json.name song.name
      json.artist song.artist
      json.uri song.uri
      json.image_url song.image_url
    end
  end
end
