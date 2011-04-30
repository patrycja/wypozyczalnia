class Car < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :rent
end
