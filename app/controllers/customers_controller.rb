class CustomersController < ApplicationController
  def show
    email = params[:email]
    @customer = Customer.includes(purchases: [:purchase_items]).find_by!(email: email)
  end
end