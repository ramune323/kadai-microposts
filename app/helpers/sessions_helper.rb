module SessionsHelper
  # 現在ログインしているユーザーを取得するメソッド
  # @current_user に既に現在のログインユーザが代入されていたら何もしない
  # 代入されていなかったら User.find(...) からログインユーザを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザがログインしていれば true
  # ログインしていなければ false
  def logged_in?
    !!current_user
  end
end
