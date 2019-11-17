require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:one)
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "total amount should be present" do
    @order.total_amount = nil
    assert_not @order.valid?
  end

  test "total amount should be greater than or equal to 0" do
    @order.total_amount = -1
    assert_not @order.valid?
    @order.total_amount = 0
    assert @order.valid?
  end

  test "customer name should be present" do
    @order.customer_name = "    "
    assert_not @order.valid?
  end

  test "customer email should be present" do
    @order.customer_email = "    "
    assert_not @order.valid?
  end

  test "customer street should be present" do
    @order.customer_street = "    "
    assert_not @order.valid?
  end

  test "customer house number should be present" do
    @order.customer_house_number = "    "
    assert_not @order.valid?
  end

  test "customer city should be present" do
    @order.customer_city = "    "
    assert_not @order.valid?
  end

  test "customer zip code should be present" do
    @order.customer_zip_code = "    "
    assert_not @order.valid?
  end

  test "customer country should be present" do
    @order.customer_country = "    "
    assert_not @order.valid?
  end

  test "credit card number should be present" do
    @order.credit_card_number = "    "
    assert_not @order.valid?
  end

  test "credit card valid until month should be present" do
    @order.credit_card_valid_until_month = "    "
    assert_not @order.valid?
  end

  test "credit card valid until year should be present" do
    @order.credit_card_valid_until_year = "    "
    assert_not @order.valid?
  end

  test "customer email validation should accept valid addresses" do
    valid_addresses = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn ]
    valid_addresses.each do | valid_address |
      @order.customer_email = valid_address
      assert @order.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "customer email validation should accept invalid addresses" do
    invalid_addresses = %w[ user@example,com user_at_foo.org
                            name@example.foo@bar_baz.com foo@bar+baz.com ]
    invalid_addresses.each do | invalid_address |
      @order.customer_email = invalid_address
      assert_not @order.valid?,
                 "#{invalid_address.inspect} should be invalid}"
    end
  end
end
