require 'rails_helper'

RSpec.describe Like, type: :feature do
  def log_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  describe 'Liking a post' do
    let(:user) { User.create(email: 'user@mail.com', name: 'user', password: '123456') }
    it 'likes a post' do
      post = user.posts.build(content: 'this is a post')
      post.save
      log_in(user)
      click_on 'Like'
      expect(page).to have_content 'You liked a post.'
      expect(user.likes.count).to eql(1)
    end
  end
end
