class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :customer,   required: false
  belongs_to :item,       required: false
  belongs_to :promotion,  required: false
end
