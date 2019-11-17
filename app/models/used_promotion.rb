class UsedPromotion < OrderItem
  def promotion_name
    promotion = Promotion.find(self.promotion_id)
    if promotion.type == 'Code'
      if promotion.percentage_off.to_f > 0
        "#{promotion.percentage_off}% off total amount"
      elsif promotion.amount_off.to_f > 0
        "#{promotion.amount_off}€ off total amount"
      end
    elsif promotion.type == 'Quantity'
      "#{promotion.item_quantity.to_i} #{Item.find(promotion.item_id).name.pluralize} " +
      "for #{promotion.total_amount}"
    end
  end
end
