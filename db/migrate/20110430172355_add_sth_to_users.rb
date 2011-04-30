class AddSthToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :imie, :string
    add_column :users, :nazwisko, :string
    add_column :users, :adres, :text
  end

  def self.down
    remove_column :users, :adres
    remove_column :users, :nazwisko
    remove_column :users, :imie
  end
end
