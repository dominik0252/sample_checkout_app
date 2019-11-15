class BasketItemsController < ApplicationController
  def index
    @basket_items = BasketItem.all
  end

  def create
    @basket_item = BasketItem.new(basket_item_params)
    if @basket_item.type == "UsingPromotion"
      reject_promotion_if_basket_empty
      reject_promotion_if_no_conjunction
      reject_promotion_if_not_enough_items
    end
    if !@reject
      if @basket_item.save
        item_name = @basket_item == 'PurchasingItem' ? @basket_item.item.name : 'Promotion'
        flash[:success] = "#{item_name} added to basket!"
      else
        flash[:danger] = "There was en error adding item to the basket"
      end
    end
    redirect_to root_url
  end

  def destroy
    @basket_item = BasketItem.find(params[:id])
    remove_quantity_promotions
    @basket_item.destroy
    flash[:success] = "Successfully removed"
    redirect_to root_url
  end

  private

  def basket_item_params
    params.require(:basket_item).permit( :basket_id, :type, :item_id, :promotion_id)
  end

  # EFFECTS:  disables adding promotion to basket if basket is empty
  def reject_promotion_if_basket_empty
    if BasketItem.all.empty?
      flash[:danger] = "Basket is empty - promotion cannot be applied!"
      @reject = true
    end
  end

  # EFFECTS:  disables adding promotion if cannot be used in conjunction with already
  #           applied promotions
  def reject_promotion_if_no_conjunction
    if  Promotion.where( id: BasketItem
                              .where( basket_id: @basket_item.basket_id,
                                      type: 'UsingPromotion')
                              .pluck(:promotion_id),
                        conjunction: false).any? ||
        Promotion.find(@basket_item.promotion_id).conjunction == false &&
          BasketItem.where( basket_id: @basket_item.basket_id,
                            type: 'UsingPromotion').any?
      flash[:danger] = "Promotion cannot be used in conjunction with already applied promotions!"
      @reject = true
    end
  end

  # EFFECTS:  disables adding quantity promotion if not enough pieces of item
  #           in the basket
  def reject_promotion_if_not_enough_items
    promotion = Promotion.find(@basket_item.promotion_id)
    if !promotion.item_id.nil?
      items_count = BasketItem.where(item_id: promotion.item_id).count
      # count pieces of the item for which promotions already applied
      item_promotions_count = 0
      Promotion.where(item_id: promotion.item_id).each do | p |
        item_promotions_count += BasketItem.where(promotion_id: p.id).count * promotion.item_quantity
      end

      if items_count - item_promotions_count < promotion.item_quantity
        flash[:danger] = "Not enough items in the basket to apply the promotion!"
        @reject = true
      end
    end
  end

  # MODIFIES: UsingPromotion
  # EFFECTS:  removes applied quantity promotion if total quantity drops below number of items in promotion
  def remove_quantity_promotions
    if @basket_item.type == "PurchasingItem"
      using_promotions_count = UsingPromotion.where(basket_id: @basket_item.basket_id).group(:promotion_id).count
      using_promotions_count.each do | promotion_id, cnt |
        promotion = Promotion.find(promotion_id)
        item_cnt = BasketItem.where(item_id: @basket_item.item_id).count - 1
        if promotion.item_id == @basket_item.item_id && cnt * promotion.item_quantity > item_cnt
          UsingPromotion.where(basket_id: @basket_item.basket_id, promotion_id: promotion.id).first.destroy
        end
      end
    end
  end
end
