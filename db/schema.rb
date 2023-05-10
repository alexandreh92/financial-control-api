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

ActiveRecord::Schema[7.0].define(version: 2023_03_03_022045) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "bank_id", null: false
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
    t.index ["number"], name: "index_accounts_on_number", unique: true
  end

  create_table "banks", force: :cascade do |t|
    t.string "name", null: false
    t.integer "external_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_banks_on_external_id", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "payee_categories", force: :cascade do |t|
    t.bigint "payee_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_payee_categories_on_category_id"
    t.index ["payee_id", "category_id"], name: "index_payee_categories_on_payee_id_and_category_id", unique: true
    t.index ["payee_id"], name: "index_payee_categories_on_payee_id"
  end

  create_table "payees", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_payees_on_name", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.string "external_id", null: false
    t.integer "transaction_type", null: false
    t.decimal "amount", precision: 15, null: false
    t.string "memo", null: false
    t.date "date", null: false
    t.bigint "payee_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["external_id", "account_id"], name: "index_transactions_on_external_id_and_account_id", unique: true
    t.index ["payee_id"], name: "index_transactions_on_payee_id"
  end

  add_foreign_key "accounts", "banks"
  add_foreign_key "payee_categories", "categories"
  add_foreign_key "payee_categories", "payees"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "payees"
end
