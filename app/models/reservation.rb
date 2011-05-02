class Reservation < ActiveRecord::Base
  has_many :cars
  has_many :users
  belongs_to :user
end
