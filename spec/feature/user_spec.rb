require 'rails_helper'
RSpec.feature 'User', type: :feature do
  scenario 'Creating a new User' do
    visit 'http://localhost:3000/users/sign_up'

    within find('#new_user') do
      fill_in 'user_name', with: 'UserName'
      fill_in 'user_email', with: 'user@gmail.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'
      click_button 'commit'
    end
  rescue StandardError => e
    puts e.message.to_s
  end
end

RSpec.describe User, type: :model do
  describe '#name' do
    let(:user) { User.create(name: 'test', email: 'test@test.com') }
    it 'it does not take user without the name' do
      user = User.new
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")

      user.name = 'test'
      user.valid?
      expect(user.errors[:name]).to_not include("can't be blank")
    end
  end

  describe '#email' do
    let(:user) { User.create(name: 'user', email: 'user@mail.com') }
    it 'doesnt take user without the email' do
      user = User.new
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'user'
      user.valid?
      expect(user.errors[:email]).to_not include("can't be blank")
    end
  end
end
