class AddIndexToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_index :albums, :mbid
  end
end
