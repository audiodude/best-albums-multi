class CreateCharts < ActiveRecord::Migration[6.0]
  def change
    create_table :charts do |t|
      t.string :name
      t.timestamps
    end

    add_reference :charts, :user, index: true
    add_foreign_key :charts, :users
  end
end
