class BillingForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :customer_email, :string
  attribute :paid_amount, :decimal
  attribute :items, default: []
  attribute :denominations, default: []

  validates :customer_email, presence: true
  validates :paid_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate  :at_least_one_item_present

  private

  def at_least_one_item_present
    if items.blank?
      errors.add(:items, "must contain at least one product")
    end
  end
end
