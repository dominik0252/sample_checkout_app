require 'test_helper'

class OrdersTest < ActionDispatch::IntegrationTest
  def setup
    @basket = baskets(:two)
    @purchased_items_count =  @basket.basket_items.where(type: 'PurchasingItem')
                                                  .group(:item_id).count
    @used_promotions_count =  @basket.basket_items.where(type: 'UsingPromotion')
                                                  .group(:promotion_id).count
    get new_order_url(basket: { id: @basket.id })
  end

  test "invalid order information" do
    assert_no_difference 'Order.count' do
      post orders_path, params: { order: {  basket_id: @basket.id,
                                            customer_name: "",
                                            customer_email: "customer@domain",
                                            customer_street: "  ",
                                            customer_house_number: "",
                                            customer_city: "",
                                            customer_zip_code: "",
                                            customer_country: "",
                                            credit_card_number: "",
                                            credit_card_valid_until_month: "",
                                            credit_card_valid_until_year: "" } }
      assert_template 'orders/new'
      assert_select 'div#error_explanation'
      assert_select 'div.field_with_errors'
      assert_select 'input[type=?][name=?][value=?]', 'hidden', 'order[basket_id]', @basket.id.to_s
    end
  end

  test "valid order information" do
    assert_difference 'Order.count', 1 do
      post orders_path, params: { order: {  basket_id: @basket.id,
                                            customer_name: "Jane Doe",
                                            customer_email: "jane.doe@example.com",
                                            customer_street: "First Avenue",
                                            customer_house_number: "1A",
                                            customer_city: "Zagreb",
                                            customer_zip_code: "10000",
                                            customer_country: "Croatia",
                                            credit_card_number: "1234-5678-9012-3456",
                                            credit_card_valid_until_month: "1",
                                            credit_card_valid_until_year: "2050" } }
      order = Order.order(created_at: :desc).first
      assert_equal  order.order_items.count,
                    @purchased_items_count.count + @used_promotions_count.count
      assert_equal @basket.basket_items.count, 0
      follow_redirect!
      assert_template 'orders/show'
      assert_select 'title', "Order ##{order.id} | Sample Checkout App"
      assert_select 'h1', "Order ##{order.id}"
    end
  end
end
