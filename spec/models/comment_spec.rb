require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  describe 'association' do
    it{ is_expected.to belong_to(:user)}
    it{ is_expected.to belong_to(:post)}
  end

  describe "validations" do
    it{ is_expected.to validate_presence_of :content }
    it{ should validate_length_of(:content).is_at_most(200).with_message('200 characters in comment is the maximum allowed.')}
  end

end 