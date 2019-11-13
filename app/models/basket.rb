class Basket < ApplicationRecord
  belongs_to :customer
  has_many :basket_items
  has_many :basket_promotions
end
