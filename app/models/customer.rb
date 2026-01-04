class Customer < ApplicationRecord
  has_many :purchases

  validates :email, presence: true, uniqueness: true
end
