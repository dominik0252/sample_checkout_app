require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    assert_difference 'Basket.count', 1 do
      get root_url
      assert_response :success
      assert_select 'title', "Home | Sample Checkout App"
      assert_select 'ul.items' do
        assert_select 'li', count: 5
      end
      get root_url
    end
  end
end
