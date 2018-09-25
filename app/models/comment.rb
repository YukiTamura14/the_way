class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :concern
  belongs_to :user
  has_many :likes, dependent: :destroy

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
