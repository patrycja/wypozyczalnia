class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars do |t|
      t.string :marka
      t.integer :poj_silnika
      t.string :typ_silnika
      t.integer :liczba_osob

      t.timestamps
    end
  end

  def self.down
    drop_table :cars
  end
end
