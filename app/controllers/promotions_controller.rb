class PromotionsController < ApplicationController
  def index
    @codes = Code.all
    @quantities = Quantity.all
  end
end
