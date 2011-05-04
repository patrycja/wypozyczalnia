class RentsController < ApplicationController
 before_filter :authenticate_user!
 
  def index
 	  @rents = Rent.find(:all)
 	  @cars = Car.find(:all)
  end

   def new
     @rent = Car.find(params[:car_id]).rents.new
   end

   def create
     @car = Car.find(params[:car_id])
     @rent = @car.rents.create(params[:rent])
     @car.update_attributes(:dostepny => :false)
     if @rent.save
       flash[:notice] = "Wypozyczono"
       redirect_to :action => "show", :id => @car, :controller => "cars"
     else
       flash[:error] = "Blad zapisu"
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
      @car.update_attributes(:dostepny => true)
      if @rent.update_attributes(params[:rent])
        flash[:notice] = "Przyjeto zwrot"
         redirect_to :action => 'show', :id => @car, :controller => "cars"
      else
         render :action => 'edit'
      end
    end

   def destroy
     @car = Car.find(params[:car_id])
     @rent = @car.rents.find(params[:id])
     @rent.destroy
     redirect_to users_path
   end

end
