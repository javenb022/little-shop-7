# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_04_220632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "created_at"
    t.string "updated_at"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer "quantity"
    t.integer "unit_price"
    t.integer "status"
    t.string "created_at"
    t.string "updated_at"
    t.bigint "item_id", null: false
    t.bigint "invoice_id", null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    t.index ["item_id"], name: "index_invoice_items_on_item_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "status"
    t.string "created_at"
    t.string "updated_at"
    t.bigint "customer_id", null: false
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "unit_price"
    t.string "created_at"
    t.string "updated_at"
    t.bigint "merchant_id", null: false
    t.integer "status", default: 1
    t.index ["merchant_id"], name: "index_items_on_merchant_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.string "created_at"
    t.string "updated_at"
    t.integer "status", default: 1
  end

  create_table "transactions", force: :cascade do |t|
    t.string "credit_card_number"
    t.string "credit_card_expiration_date"
    t.integer "result"
    t.string "created_at"
    t.string "updated_at"
    t.bigint "invoice_id", null: false
    t.index ["invoice_id"], name: "index_transactions_on_invoice_id"
  end

  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "items"
  add_foreign_key "invoices", "customers"
  add_foreign_key "items", "merchants"
  add_foreign_key "transactions", "invoices"
end
