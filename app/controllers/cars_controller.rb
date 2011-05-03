class CarsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @user = current_user
    @search = Car.search(params[:search])
    @cars = @search.all
  end
  
  def show
    @car = Car.find(params[:id])
  end
  
  def new
    @car = Car.new
  end
  
  def create
    @car = Car.new(params[:car])
     if @car.save
       redirect_to cars_path
     else
       render :action => 'new', :controller => "cars"
     end
   end
   
   def edit
     @car = Car.find(params[:id])
   end
   
   def update
     @car = Car.find(params[:id])
     if @car.update_attributes(params[:car])
        redirect_to :action => 'show', :id => @car
     else
        render :action => 'edit'
     end
   end
  
   def destroy
     @car = Car.find(params[:id])
     if @car.rents.empty?
       @car.destroy
       redirect_to cars_path
     else
      flash[:notice] = "Nie mozna usunac samochodu, ktory byl wypozyczony"
      redirect_to cars_path
     end
   end
end
