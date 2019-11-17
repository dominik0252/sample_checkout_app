class OrdersController < ApplicationController
  def new
    @order = Order.new
    if params[:basket]
      @order.basket_id = params[:basket][:id]
    else
      @order.basket_id = Basket.find_by(session_id: request.session_options[:id]).id
    end
    redirect_to root_url if @order.basket_id.nil?
  end

  def create
    @order = Order.new(order_params)
    @basket = Basket.find(@order.basket_id)
    @order.total_amount = @basket.calculate_total_amount
    if @order.save
      save_order_items
      empty_basket
      redirect_to @order
    else
      render 'new'
    end
  end

  def show
    @order = Order.find params[:id]
    @order_items = @order.order_items
  end

  private

  def order_params
    params.require(:order).permit(:basket_id,
                                  :customer_name,
                                  :customer_email,
                                  :customer_street,
                                  :customer_house_number,
                                  :customer_city,
                                  :customer_zip_code,
                                  :customer_country ,
                                  :credit_card_number,
                                  :credit_card_valid_until_month,
                                  :credit_card_valid_until_year )
  end

  # MODIFIES: OrderItem
  # EFFECTS:  Copies basket items to order items (quantity per each item / promotion)
  #           Since the details of item/promotion may change in the future, copies
  #           item price/promotion percentage, amount, total amount too
  def save_order_items
    # Save purchased items
    @purchased_items_count =  @basket.basket_items.where(type: 'PurchasingItem')
                                                  .group(:item_id).count
    @purchased_items_count.each do | item_id, item_quantity |
      order_item_params = Hash.new
      item = Item.find(item_id)
      order_item_params[:type] = 'PurchasedItem'
      order_item_params[:order_id] = @order.id
      order_item_params[:item_id] = item_id
      order_item_params[:item_quantity] = item_quantity
      order_item_params[:item_price_eur] = item.price_eur
      OrderItem.create(order_item_params)
    end
    # Save used promotions
    @used_promotions_count =  @basket.basket_items.where(type: 'UsingPromotion')
                                                  .group(:promotion_id).count
    @used_promotions_count.each do | promotion_id, promotion_quantity |
      order_promotion_params = Hash.new
      promotion = Promotion.find(promotion_id)
      order_promotion_params[:type] = 'UsedPromotion'
      order_promotion_params[:order_id] = @order.id
      order_promotion_params[:promotion_id] = promotion_id
      order_promotion_params[:item_quantity] = promotion_quantity
      if promotion.type = 'Code'
        order_promotion_params[:promotion_pct_off] = promotion.percentage_off
        order_promotion_params[:promotion_amt_off] = promotion.amount_off
      elsif promotion.type = 'Quantity'
        order_promotion_params[:promotion_tot_amt] = promotion.total_amount_amt
      end
      OrderItem.create(order_promotion_params)
    end

    # MODIFIES: BasketItems
    # EFFECTS:  Deletes all items from basket
    def empty_basket
      @basket.basket_items.each do | basket_item |
        basket_item.destroy
      end
    end
  end
end
