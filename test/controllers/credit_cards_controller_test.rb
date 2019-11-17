require 'test_helper'

class CreditCardsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @customer = customers(:one)
  end

  test "should get new" do
    get new_credit_card_url(customer: {id: @customer.id})
    assert_response :success

    assert_select 'h1', 'Add credit card'
    assert_select 'form[action=?][method=?]', '/credit_cards', 'post' do
      assert_select 'label[for=?]','credit_card_number','Number'
      assert_select 'input[type=?][name=?]','text','credit_card[number]'

      assert_select 'label[for=?]','credit_card_valid_until_month','Valid until month'
      assert_select 'input[type=?][name=?]','text','credit_card[valid_until_month]'

      assert_select 'label[for=?]','credit_card_valid_until_year','Valid until year'
      assert_select 'input[type=?][name=?]','text','credit_card[valid_until_year]'

      assert_select 'input[type=?][name=?][value=?]','submit','commit','Save credit card'
    end
  end

end
