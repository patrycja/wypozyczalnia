class Reservation < ActiveRecord::Base
  has_many :cars
  has_many :users
end
