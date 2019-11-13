# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
items = Item.create( [
  { name: 'Smart Hub', price_eur: 49.99 },
  { name: 'Motion Sensor', price_eur: 24.99 },
  { name: 'Wireless Camera', price_eur: 99.99 },
  { name: 'Smoke Sensor', price_eur: 19.99 },
  { name: 'Water Leak Sensor', price_eur: 14.99 }
])

promotions = Promotion.create( [
  { type: 'Code', percentage_off: 20, amount_off: nil, conjunction: false, item_id: nil, item_quantity: nil, total_amount: nil },
  { type: 'Code', percentage_off: 5, amount_off: nil,  conjunction: true, item_id: nil, item_quantity: nil, total_amount: nil },
  { type: 'Code', percentage_off: nil, amount_off: 20, conjunction: true, item_id: nil, item_quantity: nil, total_amount: nil },
  { type: 'Quantity', percentage_off: nil, amount_off: nil, conjunction: nil, item_id: Item.where(name: 'Motion Sensor').first.id, item_quantity: 3, total_amount: 65 },
  { type: 'Quantity', percentage_off: nil, amount_off: nil, conjunction: nil, item_id: Item.where(name: 'Smoke Sensor').first.id, item_quantity: 2, total_amount: 35 },
])
