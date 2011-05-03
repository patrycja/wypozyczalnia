class RentsController < ApplicationController
 before_filter :authenticate_user!
 
  def index
    @car = Car.find(params[:car_id])
 	  @rents = Rent.find(:all)
  end

   def new
     @rent = Car.find(params[:car_id]).rents.new
   end

   def create
     @car = Car.find(params[:car_id])
     @rent = @car.rents.create(params[:rent])
     if @rent.save
       @car.update_attributes(:dostepny => :false)
       flash[:notice] = "Wypozyczono"
       redirect_to :action => "show", :id => @car, :controller => "cars"
     else
       flash[:error] = "Błąd zapisu"
       redirect_to :action => "show", :id => @car, :controller => "cars"
     end  
   end
   
   def edit
      @car = Car.find(params[:car_id])
      @rent = @car.rents.find(params[:id])
    end

    def update
      @car = Car.find(params[:car_id])
      @rent = @car.rents.find(params[:id])
      if @car.rents.update_attributes(params[:rent])
         redirect_to :action => 'show', :id => @car, :controller => "cars"
      else
         render :action => 'edit'
      end
    end

   def destroy
     @car = Car.find(params[:car_id])
     @rent = @car.rents.find(params[:id])
     @rent.destroy
     @car.update_attributes(:dostepny => :true)
     redirect_to users_path
   end

end
