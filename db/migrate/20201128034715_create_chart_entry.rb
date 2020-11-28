class CreateChartEntry < ActiveRecord::Migration[6.0]
  def change
    create_table :chart_entries do |t|
      t.integer :position
    end

    add_reference :chart_entries, :album, index: true
    add_foreign_key :chart_entries, :albums

    add_reference :chart_entries, :chart, index: true
    add_foreign_key :chart_entries, :charts
  end
end
