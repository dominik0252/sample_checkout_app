# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_17_123619) do

  create_table "basket_items", force: :cascade do |t|
    t.integer "basket_id"
    t.string "type"
    t.integer "item_id"
    t.integer "promotion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_basket_items_on_basket_id"
    t.index ["item_id"], name: "index_basket_items_on_item_id"
    t.index ["promotion_id"], name: "index_basket_items_on_promotion_id"
  end

  create_table "baskets", force: :cascade do |t|
    t.string "session_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_baskets_on_customer_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "number"
    t.integer "valid_until_month"
    t.integer "valid_until_year"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_credit_cards_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "street"
    t.string "house_number"
    t.string "city"
    t.string "zip_code"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "price_eur"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.integer "promotion_id"
    t.float "item_quantity"
    t.float "item_price_eur"
    t.float "promotion_pct_off"
    t.float "promotion_amt_off"
    t.float "promotion_tot_amt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["promotion_id"], name: "index_order_items_on_promotion_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "basket_id"
    t.integer "customer_id"
    t.float "total_amount"
    t.string "customer_name"
    t.string "customer_email"
    t.string "customer_street"
    t.string "customer_house_number"
    t.string "customer_city"
    t.string "customer_zip_code"
    t.string "customer_country"
    t.string "credit_card_number"
    t.integer "credit_card_valid_until_month"
    t.integer "credit_card_valid_until_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_orders_on_basket_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "type"
    t.float "percentage_off"
    t.float "amount_off"
    t.boolean "conjunction"
    t.integer "item_id"
    t.integer "item_quantity"
    t.float "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
