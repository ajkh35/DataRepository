class AddUserRefToMusics < ActiveRecord::Migration[5.1]
  def change
    add_reference :musics, :user, foreign_key: true
  end
end
