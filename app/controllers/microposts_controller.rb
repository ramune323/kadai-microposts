class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  # 投稿を保存する
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      flash[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  # 投稿を削除する
  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    # このアクションが実行されたページに戻るメソッド
    # 戻るべきページがない場合には root_path に戻る
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  # 削除しようとしている Micropost が本当にログインユーザが所有しているものかを確認
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    # 見つからなければトップページに遷移
    unless @micropost
      redirect_to root_url
    end
  end
end
