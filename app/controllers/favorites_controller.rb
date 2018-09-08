class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(concern_id: params[:picture_id])
    redirect_to concerns_url, notice: 'お気に入りに登録しました'
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to concerns_url, notice: 'お気に入りを解除しました'
  end
end
