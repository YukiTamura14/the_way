class CommentsController < ApplicationController
  def create
    @concern = Concern.find(params[:concern_id])
    @comment = @concern.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js{render :index}
      else
        format.html{redirect_to concern_path(@concern), notice: '投稿できませんでした。'}
      end
    end
  end

    private

    def comment_params
      params.require(:comment).permit(:concern_id, :content)
    end
end
