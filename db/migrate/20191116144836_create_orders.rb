class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :basket, foreign_key: true
      t.references :customer, foreign_key: true
      t.float :total_amount
      t.string :customer_name
      t.string :customer_email
      t.string :customer_street
      t.string :customer_house_number
      t.string :customer_city
      t.string :customer_zip_code
      t.string :customer_country
      t.string :credit_card_number
      t.integer :credit_card_valid_until_month
      t.integer :credit_card_valid_until_year

      t.timestamps
    end
  end
end
