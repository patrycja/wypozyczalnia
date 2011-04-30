class CreateRents < ActiveRecord::Migration
  def self.up
    create_table :rents do |t|
      t.integer :id_klienta
      t.integer :id_samochodu
      t.datetime :data_wyp
      t.datetime :data_zwrotu
      t.text :uwagi

      t.timestamps
    end
  end

  def self.down
    drop_table :rents
  end
end
