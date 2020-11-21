class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :sort_name
      t.string :alias

      t.string :mbid
      t.string :spotify_id

      t.integer :type
    end
  end
end
