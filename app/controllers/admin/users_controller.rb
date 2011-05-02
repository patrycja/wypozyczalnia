class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin
  
  def index
      @users = User.find(:all)
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
  
  def become
    sign_in(:user, User.find(params[:id]))
    redirect_to user_path(:id)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    begin
    @user = User.find(params[:id])
    #TODO sprawdzanie czy user nie ma zadnych rezerwacji/wypozyczen
	  @user.destroy
      redirect_to admin_users_path
      flash[:notice] = "#{@user.name} #{@user.surname} usuniety"
	rescue Exception => e
      flash[:notice] = e.message
	  redirect_to admin_users_path
    end
  end
  
  private
  
    def authenticate_admin
	  unless current_user.admin?
	    redirect_to root_url
      end
	end

end
