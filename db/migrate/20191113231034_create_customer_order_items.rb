class CreateCustomerOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_order_items do |t|
      t.references :customer_order, foreign_key: true
      t.string :type
      t.references :item, foreign_key: true
      t.references :promotion, foreign_key: true
      t.float :total_amount

      t.timestamps
    end
  end
end
