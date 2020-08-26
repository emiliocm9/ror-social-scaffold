class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  def confirm_friend(user)
    friendship = inverse_friendships.find { |relation| relation.user == user }
    friendship2 = friendships.build
    friendship2.user_id = id
    friendship2.friend_id = user.id
    friendship2.confirmed = true
    friendship.confirmed = true
    friendship.save
    friendship2.save
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def delete_friend(user)
    friendship = inverse_friendships.find { |relation| relation.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def request_friend(user)
    return false if relation_exist?(user)

    friendship = friendships.build
    friendship.friend_id = user.id
    friendship.confirmed = false
    friendship.save
  end

  def relation_exist?(user)
    friends.include?(user) || pending_friends.include?(user) || friend_requests.include?(user) || user == self
  end
end
