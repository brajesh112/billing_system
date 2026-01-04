class Denomination < ApplicationRecord
  validates :value, presence: true, uniqueness: true
  validates :available_count, numericality: { greater_than_or_equal_to: 0 }
end
