require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe 'association' do
    it{ is_expected.to have_many(:comments) }
    it{ is_expected.to have_many(:likes) }
    it{ is_expected.to belong_to(:user)}
  end

  describe "validations" do
    it{ is_expected.to validate_presence_of :content }
    it{ should validate_length_of(:content).is_at_most(1000).with_message('1000 characters in post is the maximum allowed.')}
  end

end  

