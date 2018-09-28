class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :set_like_comment, only: [:create, :destroy]

  def create
    @like = @comment.likes.create(user_id: current_user.id)
  end

  def destroy
    @like = @comment.likes.find_by(user_id: current_user.id)
    @like.destroy
  end

  private

  def set_like_comment
    @comment = Comment.find(params[:comment_id])
  end
end
