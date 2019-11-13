class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :type
      t.float :percentage_off
      t.float :amount_off
      t.boolean :conjunction
      t.integer :item_id
      t.integer :item_quantity
      t.float :total_amount

      t.timestamps
    end
  end
end
