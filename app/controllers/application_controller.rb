class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    unless logged_in?
      flash[:error] = 'ログインしてください。'
      redirect_to new_user_path
    end
  end
end
