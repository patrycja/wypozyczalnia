class Rent < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  
  attr_accessible :data_wyp, :data_zwrotu, :uwagi, :user_id
  
  validates_datetime :data_wyp, :on => :create, :on_or_after => :now
end
