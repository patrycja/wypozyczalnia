class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.integer :id_klienta
      t.integer :id_samochodu
      t.datetime :data_od
      t.datetime :data_do

      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
