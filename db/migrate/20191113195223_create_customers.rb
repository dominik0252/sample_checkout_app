class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :street
      t.string :house_number
      t.string :city
      t.string :zip_code
      t.string :country

      t.timestamps
    end
  end
end
