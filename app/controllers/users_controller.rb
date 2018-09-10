class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: '登録しました！'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @concerns = @user.favorites
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon)
    end
end
