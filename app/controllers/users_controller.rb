class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    #dodac sprawdzanie, czy user nie ma wypozyczonego/zarezerwowanego samochodu
    @user.destroy
    redirect_to users_path
  end
end
