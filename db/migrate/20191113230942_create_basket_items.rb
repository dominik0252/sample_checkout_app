class CreateBasketItems < ActiveRecord::Migration[5.2]
  def change
    create_table :basket_items do |t|
      t.references :basket, foreign_key: true
      t.string :type
      t.references :item, foreign_key: true
      t.references :promotion, foreign_key: true

      t.timestamps
    end
  end
end
