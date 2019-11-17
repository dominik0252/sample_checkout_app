class CreditCardsController < ApplicationController
  def new
    @customer = Customer.find(params[:customer][:id])
    @credit_card = CreditCard.new
  end
end
