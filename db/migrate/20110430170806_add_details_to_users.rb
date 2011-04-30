class AddDetailsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => :false
    add_column :users, :klient, :boolean, :default => :false
    add_column :users, :recepcja, :boolean, :default => :false
  end

  def self.down
    remove_column :users, :recepcja
    remove_column :users, :klient
    remove_column :users, :admin
  end
end
