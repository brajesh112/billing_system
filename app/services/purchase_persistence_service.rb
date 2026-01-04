class PurchasePersistenceService
  def initialize(customer_email:, calculation_result:)
    @customer_email = customer_email
    @result = calculation_result
  end

  def call
    ActiveRecord::Base.transaction do
      customer = find_or_create_customer
      purchase = create_purchase(customer)
      create_items_and_update_stock(purchase)
      create_balance_denominations(purchase)
  
      send_invoice_async(purchase)
  
      purchase
    end
  end
  
  

  private

  def find_or_create_customer
    Customer.find_or_create_by!(email: @customer_email)
  end

  def create_purchase(customer)
    Purchase.create!(
      customer: customer,
      total_without_tax: @result[:totals][:total_without_tax],
      total_tax: @result[:totals][:total_tax],
      total_with_tax: @result[:totals][:total_with_tax],
      rounded_total: @result[:totals][:rounded_total],
      paid_amount: @result[:totals][:rounded_total] + @result[:balance_amount],
      balance_amount: @result[:balance_amount]
    )
  end

  def create_items_and_update_stock(purchase)
    @result[:items].each do |item|
      PurchaseItem.create!(
        purchase: purchase,
        product: item[:product],
        quantity: item[:quantity],
        unit_price: item[:unit_price],
        tax_amount: item[:tax_amount],
        total_price: item[:total_price]
      )

      item[:product].decrement!(:stock, item[:quantity])
    end
  end

  def create_balance_denominations(purchase)
    denominations = BalanceDenominationService.new(
      balance_amount: @result[:balance_amount]
    ).call
  
    denominations.each do |d|
      BalanceDenomination.create!(
        purchase: purchase,
        denomination_value: d[:value],
        count: d[:count]
      )
    end
  end
  
  def send_invoice_async(purchase)
    PurchaseMailer.invoice_email(purchase.id).deliver_later
  end
  
end
