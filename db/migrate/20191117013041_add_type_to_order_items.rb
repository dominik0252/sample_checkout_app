class AddTypeToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :type, :string
  end
end
