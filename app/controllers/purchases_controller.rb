class PurchasesController < ApplicationController
  def show
    @purchase = Purchase.includes( :purchase_items, :balance_denominations, :customer).find(params[:id])
  end
end
