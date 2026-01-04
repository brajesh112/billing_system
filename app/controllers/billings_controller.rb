class BillingsController < ApplicationController
  def new
    @billing_form = BillingForm.new
    @denominations = Denomination.order(value: :desc)
  end

  def create
    normalized = billing_params.to_h
    normalized[:items] = normalized[:items].values
    normalized[:items].reject! { |i| i[:product_code].blank? || i[:quantity].blank? }
  
    @billing_form = BillingForm.new(normalized)
  
    if @billing_form.valid?
      begin
        calculation = BillingCalculationService.new(
          items: @billing_form.items,
          paid_amount: @billing_form.paid_amount
        ).call
  
        purchase = PurchasePersistenceService.new(
          customer_email: @billing_form.customer_email,
          calculation_result: calculation
        ).call
  
        redirect_to purchase_path(purchase)
      rescue BillingCalculationService::BillingError => e
        handle_error(e.message)
      end
    else
      handle_error
    end
  end
  
  private
  
  def handle_error(message = nil)
    @billing_form.errors.add(:base, message) if message
    @denominations = Denomination.order(value: :desc)
    render :new, status: :unprocessable_entity
  end

  def billing_params
    params.require(:billing_form).permit(
      :customer_email,
      :paid_amount,
      items: [:product_code, :quantity],
      denominations: [:value, :count]
    )
  end
end
