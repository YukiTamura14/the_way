class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment, counter_cache: :likes_count
  validates :user_id, presence: true
  validates :comment_id, presence: true
end
