class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    if user_signed_in?
      @user = current_user
      @user_rentals = current_user.rents
      @user_reservations = current_user.reservations
    else
      render "index"
    end
  end
  
end
