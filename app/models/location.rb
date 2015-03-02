class Location < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true, uniqueness: true
  reverse_geocoded_by :latitude, :longitude
end
