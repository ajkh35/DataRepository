class AddYoutubeUrlToMusics < ActiveRecord::Migration[5.1]
  def change
    add_column :musics, :youtube_url, :string
  end
end
