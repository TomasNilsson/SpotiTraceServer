json.array! @followers do |follower|
  json.id follower.id
  json.username follower.username
  json.distance @user.location.distance_to(follower.location)
  json.friend @user.friends.exists?(follower)
end
