class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200,
                                                too_long: '200 in comment is the maximum allowed.' }

  belongs_to :user
  belongs_to :post
end
