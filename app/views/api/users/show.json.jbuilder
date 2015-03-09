json.id @other_user.id
json.username @other_user.username
json.distance @my_location.distance_to(@other_user.location)
json.bearing @my_location.bearing_to(@other_user.location)
json.friend @user.friends.exists?(@other_user)

song = @other_user.song
if !song.blank?
  json.song do
    json.name song.name
    json.artist song.artist
    json.uri song.uri
    json.image_url song.image_url
  end
end
