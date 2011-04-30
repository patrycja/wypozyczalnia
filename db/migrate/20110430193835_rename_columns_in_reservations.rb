class RenameColumnsInReservations < ActiveRecord::Migration
  def self.up
    rename_column :reservations, :id_klienta, :user_id
    rename_column :reservations, :id_samochodu, :car_id
  end

  def self.down
    rename_column :reservations, :user_id, :id_klienta
    rename_column :reservations, :car_id, :id_samochodu
  end
end
