class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  #has_many :friend_requests, through: :inverted_friendships, source: :name
end
