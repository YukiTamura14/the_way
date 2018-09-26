class ConcernsController < ApplicationController
  before_action :set_concern, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :edit, :destroy]
  before_action :set_user, only: [:destroy, :edit]

  def index
    @search = Concern.ransack(params[:q])
    @concerns = @search.result.order('created_at DESC')
  end

  def new
    if params[:back]
      @concern = Concern.new(concern_params)
    else
      @concern = Concern.new
    end
  end

  def create
    @concern = Concern.new(concern_params)
    @concern.user_id = current_user.id
    respond_to do |format|
      if @concern.save
        format.html{redirect_to concerns_path, notice: '投稿されました。'}
        format.js{render :index}
      else
        format.html{render :new}
        format.js{render :index}
      end
    end
  end

  def edit
  end

  def show
    @search = Concern.ransack(params[:q])
    @concerns = @search.result
    @comments = @concern.comments.all.order('created_at DESC')
    @comment = @concern.comments.build
    if logged_in?
      @favorite = current_user.favorites.find_by(concern_id: @concern.id)
    end
  end

  def update
    if @concern.update(concern_params)
      redirect_to concerns_path, notice: '投稿を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @concern.destroy
    redirect_to concerns_path, notice: '投稿を削除しました。'
  end

  def confirm
    @concern = Concern.new(concern_params)
    @concern.user_id = current_user.id
    render :new if @concern.invalid?
  end

  private

  def concern_params
    params.require(:concern).permit(:title, :content, :image, :image_cache)
  end

  def set_concern
    @concern = Concern.find(params[:id])
  end

  def set_user
    redirect_to concerns_path unless @concern.user_id == current_user.id
  end
end
