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
  
  # Micropost、フォロー／フォロワー、お気に入りの数をカウントする
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.favorite_microposts.count
  end
end
