class FavoritesController < ApplicationController
  # お気に入り追加
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    redirect_back(fallback_location: root_path)
  end

  # お気に入り削除
  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    redirect_back(fallback_location: root_path)
  end
end
