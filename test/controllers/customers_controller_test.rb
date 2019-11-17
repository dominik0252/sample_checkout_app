require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_customer_url
    assert_response :success

    assert_select 'h1', 'Enter your data'
    assert_select 'form[action=?][method=?]', '/customers', 'post' do
      assert_select 'label[for=?]','customer_name','Name'
      assert_select 'input[type=?][name=?]','text','customer[name]'

      assert_select 'label[for=?]','customer_email','Email'
      assert_select 'input[type=?][name=?]','text','customer[email]'

      assert_select 'label[for=?]','customer_street','Street'
      assert_select 'input[type=?][name=?]','text','customer[street]'

      assert_select 'label[for=?]','customer_house_number','House number'
      assert_select 'input[type=?][name=?]','text','customer[house_number]'

      assert_select 'label[for=?]','customer_city','City'
      assert_select 'input[type=?][name=?]','text','customer[city]'

      assert_select 'label[for=?]','customer_zip_code','Zip code'
      assert_select 'input[type=?][name=?]','text','customer[zip_code]'

      assert_select 'label[for=?]','customer_country','Country'
      assert_select 'input[type=?][name=?]','text','customer[country]'

      assert_select 'input[type=?][name=?][value=?]','submit','commit','Save'
    end
  end
end
