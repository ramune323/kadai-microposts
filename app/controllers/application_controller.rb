class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    # falseの場合、処理を実行する（unless は if の反対）
    # ログインしていなければログインページへ強制的にリダイレクト
    unless logged_in?
      redirect_to login_url
    end
  end
  
  # Micropostの数をカウントする
  def counts(user)
    @count_microposts = user.microposts.count
  end
end
