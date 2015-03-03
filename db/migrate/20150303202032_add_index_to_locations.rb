class AddIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, [:latitude, :longitude]
  end
end
