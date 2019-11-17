class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.references :promotion, foreign_key: true
      t.float :item_quantity
      t.float :item_price_eur
      t.float :promotion_pct_off
      t.float :promotion_amt_off
      t.float :promotion_tot_amt

      t.timestamps
    end
  end
end
