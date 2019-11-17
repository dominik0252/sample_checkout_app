require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @sample_customer = customers(:one)
    @another_customer = customers(:two)
  end

  test "should be valid" do
    assert @sample_customer.valid?
  end

  test "name should be present" do
    @sample_customer.name = "    "
    assert_not @sample_customer.valid?
  end

  test "email should be present" do
    @sample_customer.email = "    "
    assert_not @sample_customer.valid?
  end

  test "street should be present" do
    @sample_customer.street = "    "
    assert_not @sample_customer.valid?
  end

  test "house_number should be present" do
    @sample_customer.house_number = "    "
    assert_not @sample_customer.valid?
  end

  test "city should be present" do
    @sample_customer.city = "    "
    assert_not @sample_customer.valid?
  end

  test "zip_code should be present" do
    @sample_customer.zip_code = "    "
    assert_not @sample_customer.valid?
  end

  test "country should be present" do
    @sample_customer.country = "    "
    assert_not @sample_customer.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn ]
    valid_addresses.each do | valid_address |
      @sample_customer.email = valid_address
      assert @sample_customer.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should accept invalid addresses" do
    invalid_addresses = %w[ user@example,com user_at_foo.org
                            name@example.foo@bar_baz.com foo@bar+baz.com ]
    invalid_addresses.each do | invalid_address |
      @sample_customer.email = invalid_address
      assert_not @sample_customer.valid?,
                 "#{invalid_address.inspect} should be invalid}"
    end
  end

  test "email address should be unique" do
    duplicate_customer = @sample_customer.dup
    duplicate_customer.email = @sample_customer.email.upcase
    @sample_customer.save
    assert_not duplicate_customer.valid?
  end
end
