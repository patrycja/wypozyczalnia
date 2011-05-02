class AddDostepnyToCars < ActiveRecord::Migration
  def self.up
    add_column :cars, :dostepny, :boolean
  end

  def self.down
    remove_column :cars, :dostepny, :boolean
  end
end
