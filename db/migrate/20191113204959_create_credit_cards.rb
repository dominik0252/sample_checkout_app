class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.integer :valid_until_month
      t.integer :valid_until_year
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
