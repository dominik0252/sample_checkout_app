class CustomerOrderItem < ApplicationRecord
  belongs_to :customer_order
  belongs_to :item
  belongs_to :promotion
end
