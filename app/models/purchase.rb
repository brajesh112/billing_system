class Purchase < ApplicationRecord
  belongs_to :customer

  has_many :purchase_items, dependent: :destroy
  has_many :balance_denominations, dependent: :destroy

  accepts_nested_attributes_for :purchase_items
end
