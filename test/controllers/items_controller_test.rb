require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    assert_equal Basket.count, 0
    get root_url
    assert_response :success
    assert_select 'h1', 'Online Shop'
    assert_select 'ul.items' do
      assert_select 'li', count: 5
    end
    assert_equal Basket.count, 1
    get root_url
    assert_equal Basket.count, 1
  end
end
