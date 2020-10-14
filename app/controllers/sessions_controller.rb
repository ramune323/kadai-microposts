class SessionsController < ApplicationController
  def new
  end

  # ログイン
  def create
    # フォームのemailとpasswordを取得
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(email, password)
      # ログイン成功→ユーザ詳細ページへ（users#show）
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      # ログイン失敗→sessions/new.html.erb を再表示
      flash[:danger] = "ログインに失敗しました。"
      render :new
    end
  end

  # ログアウト
  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  private

  def login(email, password)
    # 入力フォームのemailと同じメールアドレスを持つユーザを検索し @user へ代入
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password) # パスワードが合っているか
      # ログイン成功
      session[:user_id] = @user.id # ブラウザにはCookieとして、サーバにはSessionとして、ログイン状態が維持される
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
