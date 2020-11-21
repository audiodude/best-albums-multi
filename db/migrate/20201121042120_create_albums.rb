class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :date
    end

    add_reference :albums, :artist, index: true
    add_foreign_key :albums, :artists
  end
end
