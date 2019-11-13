class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :item
  belongs_to :promotion
end
