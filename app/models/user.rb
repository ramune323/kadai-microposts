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
end
