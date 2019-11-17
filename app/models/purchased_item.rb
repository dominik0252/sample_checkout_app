class PurchasedItem < OrderItem
  def item_name
    name = Item.find(self.item_id).name
    self.item_quantity == 1 ? name : name.pluralize
  end
  def item_icon
    Item.find(self.item_id).icon
  end
end
