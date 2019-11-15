require 'test_helper'

class BasketItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get basket_items_url
    assert_response :success
  end

end
