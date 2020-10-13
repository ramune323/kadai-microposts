module UsersHelper
  def gravatar_url(user, options = { size: 80 }) # 画像サイズを指定
    # user.email を downcase（小文字に変換）し暗号化した文字列を代入
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    # 以下の画像URLを返す
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
