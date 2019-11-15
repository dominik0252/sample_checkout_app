class Basket < ApplicationRecord
  belongs_to :customer, required: false
  has_many :basket_items
  has_many :basket_promotions

  def calculate_total_amount
    total_pct_off = 0
    total_amount_off = 0
    total_items_amount = 0
    total_promotions_amount = 0
    purchasing_items = self.basket_items.where(type: 'PurchasingItem')
    purchasing_items_count = purchasing_items.group(:item_id).count
    self.basket_items.where(type: 'UsingPromotion').each do |basket_item|
      promotion = Promotion.find(basket_item.promotion_id)
      if promotion.percentage_off.to_f > 0.0
        total_pct_off += promotion.percentage_off
      elsif promotion.amount_off.to_f > 0.0
        total_amount_off -= promotion.amount_off
      elsif promotion.item_quantity.to_i > 0
        purchasing_items_count[promotion.item_id] -= promotion.item_quantity
        total_promotions_amount += promotion.total_amount
      end
    end
    purchasing_items_count.each do | item_id, count |
      item = Item.find(item_id)
      total_items_amount += count * item.price_eur
    end

    total_amount =  (1 - total_pct_off / 100) *
                    (total_items_amount + total_promotions_amount + total_amount_off)
    total_amount = 0 if total_amount < 0

    return total_amount
  end
end
