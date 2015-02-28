class User < ActiveRecord::Base
  has_one :song
  has_one :location
  validates :username, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
end
