class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to new_credit_card_url(customer: {id: @customer.id})
    else
      render 'new'
    end
  end

  private

  def customer_params
    params.require(:customer).permit( :name,
                                      :email,
                                      :street,
                                      :house_number,
                                      :city,
                                      :zip_code,
                                      :country )
  end
end
