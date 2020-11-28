class Chart < ApplicationRecord
  has_many :chart_entries
  has_many :albums, -> { order(position: :asc) }, through: :chart_entries
end
