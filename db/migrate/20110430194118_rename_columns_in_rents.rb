class RenameColumnsInRents < ActiveRecord::Migration
  def self.up
    rename_column :rents, :id_klienta, :user_id
    rename_column :rents, :id_samochodu, :car_id
  end

  def self.down
    rename_column :rents, :user_id, :id_klienta
    rename_column :rents, :car_id, :id_samochodu
  end
end
