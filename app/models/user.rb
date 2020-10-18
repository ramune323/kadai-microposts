class User < ApplicationRecord
  # User インスタンス（レコード）を保存する前に実行する
  # 文字を全て小文字に変換する（! は自分自身を直接変換）
  before_save { self.email.downcase! }
  
  # name のバリデーション　カラを許さない、50文字以内
  validates :name, presence: true, length: { maximum: 50 }
  
  # email のバリデーション　カラを許さない、255文字以内
  # 正規表現でメールアドレスに使用できる文字や形式かどうか判断
  # 重複を許さず、大文字と小文字は区別しない
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  # 暗号化のための機能
  has_secure_password
  
  # User と Micropost の一対多を表現
  has_many :microposts
  # フォローUser と フォロワーUser の 多対多
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    # フォローの相手が自分自身でないか
    unless self == other_user
      # follow_id == other_user_id が見つかれば Relationshipモデル（クラス）のインスタンスを返す
      # 見つからなければ新規作成し保存
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  # フォローがあればアンフォローする
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship # relationshipが存在すれば削除
  end
  
  # other_user はフォローしているユーザか？ true or false
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  # 自分とフォローuserの Micropost を全て取得する
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
end
