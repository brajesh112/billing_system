class BillingCalculationService
  class BillingError < StandardError; end

  def initialize(items:, paid_amount:)
    @items = items
    @paid_amount = paid_amount.to_d
  end

  def call
    calculated_items = calculate_items
    totals = calculate_totals(calculated_items)

    balance = @paid_amount - totals[:rounded_total]

    raise BillingError, "Insufficient paid amount" if balance.negative?

    {
      items: calculated_items,
      totals: totals,
      balance_amount: balance
    }
  end

  private

  def calculate_items
    @items.map do |item|
      product = Product.find_by(product_code: item[:product_code])

      raise BillingError, "Invalid product code: #{item[:product_code]}" if product.nil?

      quantity = item[:quantity].to_i
      raise BillingError, "Invalid quantity for #{product.product_code}" if quantity <= 0

      if product.stock < quantity
        raise BillingError, "Insufficient stock for #{product.product_code}"
      end

      unit_price = product.unit_price
      base_price = unit_price * quantity
      tax_amount = (base_price * product.tax_percentage / 100).round(2)
      total_price = base_price + tax_amount

      {
        product: product,
        product_code: product.product_code,
        unit_price: unit_price,
        quantity: quantity,
        base_price: base_price,
        tax_amount: tax_amount,
        total_price: total_price
      }
    end
  end

  def calculate_totals(items)
    total_without_tax = items.sum { |i| i[:base_price] }
    total_tax         = items.sum { |i| i[:tax_amount] }
    total_with_tax    = total_without_tax + total_tax
    rounded_total     = total_with_tax.floor

    {
      total_without_tax: total_without_tax,
      total_tax: total_tax,
      total_with_tax: total_with_tax,
      rounded_total: rounded_total
    }
  end
end
