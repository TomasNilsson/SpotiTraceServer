class User < ActiveRecord::Base
  has_one :song
  has_one :location
  belongs_to :master_user, class_name: "User"
  has_many :followers, class_name: "User", foreign_key: "master_user_id"
  has_many :friendships
  has_many :friends, through: :friendships

  validates :username, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
end
