class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :item, required: false
  belongs_to :promotion, required: false
end
