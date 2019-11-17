class ItemsController < ApplicationController
  def index
    @items = Item.all

    @basket = Basket.find_or_create_by!(session_id: request.session_options[:id])
    # items in basket
    @purchasing_items = PurchasingItem.where(basket_id: @basket.id)
    @purchasing_items_count = @purchasing_items.group(:item_id).count

    get_promotions
  end

  private

  # EFFECTS:  get already applied promotions, eligible code promotions and eligible
  #           quantity promotions
  def get_promotions
    if @purchasing_items.any?
      get_using_promotions
      get_eligible_codes
      get_eligible_quantities
    end
  end

  # EFFECTS:  getting already applied promotions to basket
  def get_using_promotions
    @using_promotions = UsingPromotion.where(basket_id: @basket.id)
    if @using_promotions
      @using_promotions_count = @using_promotions.group(:promotion_id).count
    end
  end

  # EFFECTS:  getting eligible code promotions
  #           taking into account conuction with other promotions
  def get_eligible_codes
    conjunction_false_promotion_applied = false
    code_promotion_applied = false
    using_promotions_ids = @using_promotions.pluck(:promotion_id)

    # if a promotion with conjunction=false applied, no other Code promotions eligible
    if Promotion.where(id: using_promotions_ids, conjunction: false).any?
      conjunction_false_promotion_applied = true
    # if any promotion applied, no Code promotions with conjuction=false eligible
    elsif Promotion.where(id: using_promotions_ids, type: 'Code').any?
      code_promotion_applied = true
    end

    if !conjunction_false_promotion_applied
      if code_promotion_applied
        @codes = Code.where("id NOT IN (#{using_promotions_ids.join(',')}) AND conjunction = ?", true)
      else
        @codes = Code.where("id NOT IN (#{using_promotions_ids.join(',')})")
      end
    end
  end

  # EFFECTS:  getting eligible quantity promotions
  #           taking into account number of items in basket and number of items
  #           in applied promotions
  def get_eligible_quantities
    quantity_ids = Array.new
    Quantity.all.each do | quantity |
      # if any promotions already applied, consider number of items in basket
      #   minus number of items in applied promotions
      if @using_promotions
        if quantity.item_quantity <= @purchasing_items_count[quantity.item_id].to_i -
                                    (@using_promotions_count[quantity.id].to_i *
                                      quantity.item_quantity)
          quantity_ids << quantity.id
        end
      # if no promotions applied consider only number of items in the basket
      else
        if quantity.item_quantity <= @purchasing_items_count[quantity.item_id].to_i
          quantity_ids << quantity.id
        end
      end
    end

    @quantities = Quantity.where(id: quantity_ids)
  end
end
