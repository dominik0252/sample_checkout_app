class CreateCustomerOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_orders do |t|
      t.references :customer, foreign_key: true
      t.references :credit_card, foreign_key: true
      t.float :total_amount

      t.timestamps
    end
  end
end
