require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  def setup
    @sample_credit_card = credit_cards(:one)
    @another_credit_card = credit_cards(:two)
  end

  test "number should be present" do
    @sample_credit_card.number = "   "
    assert_not @sample_credit_card.valid?
  end

  test "valid_until_month should be present" do
    @sample_credit_card.valid_until_month = nil
    assert_not @sample_credit_card.valid?
  end

  test "valid_until_year should be present" do
    @sample_credit_card.valid_until_year = nil
    assert_not @sample_credit_card.valid?
  end

  test "customer_id should be present" do
    @sample_credit_card.customer_id = nil
    assert_not @sample_credit_card.valid?
  end

  test "valid_until_month should be valid month" do
    @sample_credit_card.valid_until_month = 0
    assert_not @sample_credit_card.valid?
    @sample_credit_card.valid_until_month = 13
    assert_not @sample_credit_card.valid?
    @sample_credit_card.valid_until_month = 1
    assert @sample_credit_card.valid?
    @sample_credit_card.valid_until_month = 6
    assert @sample_credit_card.valid?
    @sample_credit_card.valid_until_month = 12
    assert @sample_credit_card.valid?
  end

  test "card expiration should be in the future" do
    @sample_credit_card.valid_until_month = 6
    @sample_credit_card.valid_until_year = 2019
    assert_not @sample_credit_card.valid?
    @sample_credit_card.valid_until_month = 12
    @sample_credit_card.valid_until_year = 2999
    assert @sample_credit_card.valid?
  end
end
