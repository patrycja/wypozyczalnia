class ReservationsController < ApplicationController
  before_filter :authenticate_user!

   def index
     @car = Car.find(params[:car_id])
  	 @reservations = Reservation.find(:all)
   end

    def new
      @reservation = Car.find(params[:car_id]).reservations.new
    end

    def create
      @car = Car.find(params[:car_id])
      @reservation = @car.reservations.create(params[:reservation])
       if @reservation.save
        @reservation.update_attributes(:user_id => current_user.id)
        flash[:notice] = "Zarezerwowano"
        redirect_to :action => "show", :id => @car, :controller => "cars"
      else
        flash[:error] = "Kolizja rezerwacji, prosze wybrac inna date"
        redirect_to :action => "show", :id => @car, :controller => "cars"
      end  
    end
    
    def edit
       @car = Car.find(params[:car_id])
       @rent = @car.reservations.find(params[:id])
    end

    def update
       @car = Car.find(params[:car_id])
       @rent = @car.reservations.find(params[:id])
       if @car.reservations.update_attributes(params[:reservation])
          redirect_to :action => 'show', :id => @car, :controller => "cars"
       else
          render :action => 'edit'
       end
    end

    def destroy
      @car = Car.find(params[:car_id])
      @reservation = @car.reservations.find(params[:id])
      @reservation.destroy
      redirect_to cars_path(@car)
    end
    
end
