class ReservationsController < ApplicationController
  attr_accessor :data_od, :data_do
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
      #from = params[:data_od]
      #to = params[:data_do]
      #if check_reservation(from, to)
        @reservation = @car.reservations.create(params[:reservation])
        @reservation.update_attributes(:user_id => current_user.id)
       if @reservation.save
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
    
    private

    def check_reservation(from, to)
      all_res = @car.reservations.find(:all).to_a
      earlier_res = @car.reservations.find(:all, :conditions => ["data_od < '#{from}' AND data_do < '#{to}'"]).to_a
      later_res = @car.reservations.find(:all, :conditions => ["data_od > '#{from}' AND data_do > '#{to}'"]).to_a
      collision_list = all_res - earlier_res - later_res
      if collision_list.any?
        return false
      else
        return true
      end
    end
end
