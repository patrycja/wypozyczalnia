class Reservation < ActiveRecord::Base
  belongs_to :car
  belongs_to :user
  
  validates_presence_of :data_od, :data_do
  
  before_validation_on_create :check_reservation
  validates_datetime :data_od, :on => :create, :on_or_after => :now
  validates_datetime :data_do, :on => :create, :on_or_after => :now
  
  def check_reservation
    @car = Car.find(:all, :conditions => ["id = ?", self.car_id]).first
    all_res = @car.reservations.find(:all).to_a
    earlier_res = @car.reservations.find(:all, :conditions => ["data_do < ?", self.data_od]).to_a
    later_res = @car.reservations.find(:all, :conditions => ["data_od > ?", self.data_do]).to_a
    collision_list = all_res - earlier_res - later_res
    if collision_list.any?
      return false
    end
    return true
  end
  
end
