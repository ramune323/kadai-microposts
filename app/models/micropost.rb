class Micropost < ApplicationRecord
  # User と Micropost の一対多を表現
  belongs_to :user
  # Micropost と Favorite の一対多
  has_many :favorites
  # Favorite 経由で User を参照する
  has_many :favorited_users, through: :favorites, source: :user
  
  # カラを許さない、255文字以内
  validates :content, presence: true, length: { maximum: 255 }
end
