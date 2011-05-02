class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user = current_user
    if user_signed_in?
      redirect_to users_path
    else
      redirect_to cars_path
    end
  end
  
end
