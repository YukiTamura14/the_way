class CommentsController < ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :ensure_correct_poster, only: [:edit, :destroy]
  before_action :set_concern_comment, only: [:create, :edit, :update]

  def create
    @comment = current_user.post_comment(@concern, params[:comment])
    @likes = Like.where(comment_id: params[:id])
    if @comment.save
      render :show
    else
      render json: @comment.errors, status: 422
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to concern_path(@concern.id), notice:"編集しました"
    else
      render :edit
    end
  end

  def destroy
    @concern = Concern.find(params[:concern_id])
    @comment.destroy
    redirect_to concern_path(@concern.id), notice:"削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:concern_id, :content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def ensure_correct_poster
    redirect_to concerns_path(@concern) unless @comment.user_id == current_user.id
  end

  def set_concern_comment
    @concern = Concern.find(params[:concern_id])
  end

end
