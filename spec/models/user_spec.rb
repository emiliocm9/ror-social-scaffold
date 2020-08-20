require 'rails_helper'

RSpec.describe User, type: :model do
  context 'context' do
    before do
      @user1 = User.create(email: 'emaile@mail.com', name: 'User1', password: '123456')
      @user2 = User.create(email: 'email2@mail.com', name: 'User2', password: '123456')
    end

    it 'pending_friends' do
      @user1.request_friend(@user2)
      expect(@user1.pending_friends.first.id).to be @user2.id
    end

    it 'friend_requests' do
      @user1.request_friend(@user2)
      expect(@user2.friend_requests.first.id).to be @user1.id
    end

    it 'confirm_friend' do
      @user1.request_friend(@user2)
      @user2.confirm_friend(@user1)
      user1 = User.find(@user1.id)
      expect(user1.friends.first.id).to be @user2.id
    end

    it 'request friend secound time' do
      @user1.request_friend(@user2)
      expect(@user1.request_friend(@user2)).to be false
    end

    it 'Reject friend request' do
      @user1.request_friend(@user2)
      @user2.delete_friend(@user1)
      user1 = User.find(@user1.id)
      expect(user1.friends.first).to be nil
    end

    it 'Friend checking' do
      @user1.request_friend(@user2)
      @user2.confirm_friend(@user1)
      user1 = User.find(@user1.id)
      expect(user1.friend?(@user2)).to be true
    end

    it 'Friend yourself' do
      expect(@user1.relation_exist?(@user1)).to be true
    end
  end
end
