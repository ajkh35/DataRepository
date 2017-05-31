class CreateMusics < ActiveRecord::Migration[5.1]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.integer :year

      t.timestamps
    end
  end
end
