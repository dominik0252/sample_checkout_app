require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @basket = baskets(:two)
  end

  test "should get new" do
    get new_order_url(basket: { id: @basket.id })
    assert_response :success

    assert_select 'title', 'New Order | Sample Checkout App'
    assert_select 'h1', 'Order details'
    assert_select 'form[action=?][method=?]', '/orders', 'post' do
      # basket id must be present and hidden
      assert_select 'input[type=?][name=?][value=?]', 'hidden', 'order[basket_id]', @basket.id.to_s

      assert_select 'label[for=?]','order_customer_name','Name'
      assert_select 'input[type=?][name=?]','text','order[customer_name]'

      assert_select 'label[for=?]','order_customer_email','Email'
      assert_select 'input[type=?][name=?]','text','order[customer_email]'

      assert_select 'label[for=?]','order_customer_street','Street'
      assert_select 'input[type=?][name=?]','text','order[customer_street]'

      assert_select 'label[for=?]','order_customer_house_number','House number'
      assert_select 'input[type=?][name=?]','text','order[customer_house_number]'

      assert_select 'label[for=?]','order_customer_city','City'
      assert_select 'input[type=?][name=?]','text','order[customer_city]'

      assert_select 'label[for=?]','order_customer_zip_code','Zip code'
      assert_select 'input[type=?][name=?]','text','order[customer_zip_code]'

      assert_select 'label[for=?]','order_customer_country','Country'
      assert_select 'input[type=?][name=?]','text','order[customer_country]'

      assert_select 'label[for=?]','order_credit_card_number','Credit card number'
      assert_select 'input[type=?][name=?]','text','order[credit_card_number]'

      assert_select 'label[for=?]','order_credit_card_valid_until_month','Credit card valid until (month)'
      assert_select 'input[type=?][name=?]','text','order[credit_card_valid_until_month]'

      assert_select 'label[for=?]','order_credit_card_valid_until_year','Credit card valid until (year)'
      assert_select 'input[type=?][name=?]','text','order[credit_card_valid_until_year]'

      assert_select 'input[type=?][name=?][value=?]','submit','commit','Proceed to checkout'
    end
  end
end
