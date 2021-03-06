class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes]
  
  # ユーザ一覧を取得（id降順）　ページネーション適用　1ページに25件表示
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  # ユーザ詳細ページ表示
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  # ユーザ新規作成
  def new
    @user = User.new
  end

  # ユーザ登録（保存）
  def create
    @user = User.new(user_params)
    
    # 登録後、showアクションを実行しユーザ詳細ページ表示
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    # 失敗したらユーザ登録ページへ遷移
    else
      flash[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  # フォロー一覧表示
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  # フォロワー一覧表示
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  # お気に入り一覧表示
  def likes
    @user = User.find(params[:id])
    @favorites = @user.favorite_microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end