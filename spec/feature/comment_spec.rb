require 'rails_helper'

RSpec.describe Comment, type: :feature do
  def log_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  describe 'commenting on a post' do
    let(:user) { User.create(email: 'user@mail.com', name: 'user', password: '123456') }
    let(:comment) { 'commenting on my own post' }

    it 'comments on a post' do
      post = user.posts.build(content: 'This is a comment for my post')
      post.save
      log_in(user)
      fill_in 'comment_content', with: comment
      click_on 'Comment'
      expect(page).to have_content 'Comment was successfully created.'
      expect(page).to have_content "#{user.name}: #{comment}"
    end
  end
end
