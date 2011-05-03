class AddDostepnyToCars < ActiveRecord::Migration
  def self.up
    add_column :cars, :dostepny, :boolean, :default => :true
  end

  def self.down
    remove_column :cars, :dostepny
  end
end
