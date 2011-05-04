class Reservation < ActiveRecord::Base
  belongs_to :car
  belongs_to :user
  
  validates_presence_of :data_od, :data_do
  
  before_validation_on_create :check_reservation
  validates_datetime :data_od, :on => :create, :on_or_after => :now
  validates_datetime :data_do, :on => :create, :on_or_after => :now
  
  def check_reservation
    @car = Car.find(:first, :conditions => ["id = ?", self.car_id])
    coliding = @car.reservations.where("(data_od <= :data_od and data_do >= :data_od) or (data_od <= :data_do and data_do >= :data_do)",
                                      {:data_od => self.data_od, :data_do => self.data_do}).count
    return (coliding == 0)    
  end
  
end
