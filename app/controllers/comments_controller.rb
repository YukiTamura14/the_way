class CommentsController < ApplicationController
  def create
    @concern = Concern.find(params[:concern_id])
    @comment = @concern.comments.build(content: params[:comment])
    if @comment.save
      render json: @comment
    end
  end

    private

    def comment_params
      params.require(:comment).permit(:concern_id, :content)
    end
end
