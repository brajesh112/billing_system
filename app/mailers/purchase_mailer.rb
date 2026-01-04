class PurchaseMailer < ApplicationMailer
  default from: "no-reply@billing-system.com"

  def invoice_email(purchase_id)
    @purchase = Purchase.includes(
      :purchase_items,
      :balance_denominations,
      :customer
    ).find(purchase_id)

    mail(
      to: @purchase.customer.email,
      subject: "Invoice for your purchase ##{@purchase.id}"
    )
  end
end
