class CarsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  attr_reader :per_page
  
  def index
    @user = current_user
    
    if(params[:from] and params[:to])
      from = convert_date(params[:cars], :from)
      to = convert_date(params[:cars], :to)
      @cars = Car.available_in(from, to)
    else
      cars = Car.all
      @cars = cars.paginate :page => params[:page], :per_page => 5
    end
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
   
   private

   def convert_date(hash, date_symbol_or_string)
     attribute = date_symbol_or_string.to_s
     return Date.new(hash[attribute + '(1i)'].to_i, hash[attribute + '(2i)'].to_i, hash[attribute + '(3i)'].to_i)   
   end
end
