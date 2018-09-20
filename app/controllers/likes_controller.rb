class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @comment = Comment.find(params[:comment_id])
    @like = @comment.likes.create(user_id: current_user.id)
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @like = @comment.likes.find_by(user_id: current_user.id)
    @like.destroy
  end
end
