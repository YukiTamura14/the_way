class CommentsController < ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @concern = Concern.find(params[:concern_id])
    @comment = @concern.comments.build(content: params[:comment])
    @likes = Like.where(comment_id: params[:id])
    @comment.user_id = current_user.id
    if @comment.save
      render :show
    else
      render json: @comment.errors, status: 422
    end
  end

  def edit
    @concern = Concern.find(params[:concern_id])
  end

  def update
    @concern = Concern.find(params[:concern_id])
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
end
