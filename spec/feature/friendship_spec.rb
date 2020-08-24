require 'rails_helper'

RSpec.describe 'Friendship', type: :feature, feature: true do
  context 'context' do
    before do
      @user = User.create(email: 'user1@mail.com', name: 'User1', password: '123456')
      @user2 = User.create(email: 'user2@mail.com', name: 'User2', password: '123456')
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'user1@mail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end

    scenario 'log_in valid' do
      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'friend request' do
      url = 'http://localhost:3000/users/'
      url.concat(@user2.id.to_s)
      visit url
      page.all('a')[4].click
      expect(@user.pending_friends).to include(@user2)
      expect(page).to have_content('Success')
    end

    scenario 'confirm friend' do
      url = 'http://localhost:3000/users/'
      url.concat(@user2.id.to_s)
      visit url
      page.all('a')[4].click
      click_on 'Sign out'
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'user2@mail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      url = 'http://localhost:3000/users/'
      url.concat(@user.id.to_s)
      visit url
      page.all('a')[5].click
      expect(page).to have_content('You have a new friend!')
      expect(@user.friends).to include(@user2)
    end

    scenario 'friend reject' do
      url = 'http://localhost:3000/users/'
      url.concat(@user2.id.to_s)
      visit url
      page.all('a')[4].click
      click_on 'Sign out'
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'user2@mail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      url = 'http://localhost:3000/users/'
      url.concat(@user.id.to_s)
      visit url
      page.all('a')[4].click
      expect(page).to have_content('Friend deleted')
    end
  end
end