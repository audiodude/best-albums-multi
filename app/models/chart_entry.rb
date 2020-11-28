class ChartEntry < ApplicationRecord
  belongs_to :chart
  belongs_to :album
  acts_as_list scope: :chart
end
