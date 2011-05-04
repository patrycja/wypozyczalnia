class UsersController < ApplicationController
  before_filter :authenticate_user!
  attr_reader :per_page
  
  def index
    @user = current_user
    users = User.find(:all)
    @users = users.paginate :page => params[:page], :per_page => 3
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
    if @user.rents.empty?
      @user.destroy
      redirect_to users_path
    else
      redirect_to users_path
      flash[:notice] = "Nie mozna usunac uzytkownika, ktory wypozyczal samochod"
    end
  end
end
