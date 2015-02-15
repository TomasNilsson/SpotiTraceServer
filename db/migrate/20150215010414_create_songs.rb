class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :album
      t.string :uri
      t.string :image_url

      t.timestamps
    end
  end
end
