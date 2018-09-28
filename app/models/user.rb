class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :password, presence: true, length:{minimum:6}
  has_many :favorite_concerns, through: :favorite, source: :concern, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :concerns, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password
  mount_uploader :icon, IconUploader
end
