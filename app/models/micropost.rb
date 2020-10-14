class Micropost < ApplicationRecord
  # User と Micropost の一対多を表現
  belongs_to :user
  
  # カラを許さない、255文字以内
  validates :content, presence: true, length: { maximum: 255 }
end
