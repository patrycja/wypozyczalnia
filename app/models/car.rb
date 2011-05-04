class Car < ActiveRecord::Base  
  has_many :reservations
  has_many :rents
  
  def self.available_in(from, to)
    reserved = Reservation.where("(data_od < :data_od and data_do > :data_od) or (data_od < :data_do and data_do > :data_do)", {:data_od => from, :data_do => to})
    unless reserved.empty?
      unavailable = reserved.map(&:car_id).uniq.join(", ")
      cars = Car.where("id not in (:forbidden)", :forbidden => unavailable)
    else
      cars = Car.all
    end
    cars
  end
end
