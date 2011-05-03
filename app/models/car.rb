class Car < ActiveRecord::Base  
  has_many :reservations
  has_many :rents

end
