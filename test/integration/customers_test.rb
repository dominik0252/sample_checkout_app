require 'test_helper'

class CustomersTest < ActionDispatch::IntegrationTest
  test "invalid customer information" do
    get new_customer_path
    assert_no_difference 'Customer.count' do
      post customers_path, params: {customer: { name: "",
                                                email: "customer@domain",
                                                street: "  ",
                                                house_number: "",
                                                city: "",
                                                zip_code: "",
                                                country: "" } }
    end
    assert_template 'customers/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid customer information" do
    get new_customer_path
    assert_difference 'Customer.count', 1 do
      post customers_path, params: { customer: {  name: "Jane Doe",
                                                  email: "jane.doe@example.com",
                                                  street: "First Avenue",
                                                  house_number: "1A",
                                                  city: "Zagreb",
                                                  zip_code: "10000",
                                                  country: "Croatia"
        }}
    end
    follow_redirect!
    assert_template 'credit_cards/new'
  end
end
