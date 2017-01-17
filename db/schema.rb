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

ActiveRecord::Schema.define(version: 20170117025830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_rates", force: :cascade do |t|
    t.string   "shipmentID"
    t.string   "carrier_scac"
    t.float    "nmfc_class",                           default: 70.0
    t.string   "orig_5zip"
    t.string   "orig_state"
    t.string   "orig_country",                         default: "USA"
    t.string   "dest_5zip"
    t.string   "dest_state"
    t.string   "dest_country",                         default: "USA"
    t.integer  "weight"
    t.decimal  "disc_charge",  precision: 9, scale: 2
    t.decimal  "discount",     precision: 4, scale: 3
    t.decimal  "charge",       precision: 9, scale: 2
    t.decimal  "min",          precision: 5, scale: 2
    t.string   "error_code",                           default: "NONE"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "ltl_discounts", force: :cascade do |t|
    t.string   "carrier_scac"
    t.string   "origin_state"
    t.string   "dest_state"
    t.decimal  "discount",     precision: 4, scale: 3
    t.decimal  "min",          precision: 5, scale: 2
    t.datetime "created_at",                           default: -> { "now()" }, null: false
    t.datetime "updated_at",                           default: -> { "now()" }, null: false
    t.string   "group"
    t.string   "dest_zip"
  end

  create_table "ltl_weight_groups", force: :cascade do |t|
    t.integer  "min_weight"
    t.integer  "max_weight"
    t.integer  "rate_block_number"
    t.text     "weight_group_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "rates", force: :cascade do |t|
    t.string   "carrier_scac"
    t.float    "nmfc_class"
    t.string   "orig_3zip"
    t.string   "dest_3zip"
    t.string   "weight_group_name"
    t.float    "cwt"
    t.datetime "created_at",        default: -> { "now()" }, null: false
    t.datetime "updated_at",        default: -> { "now()" }, null: false
    t.float    "ctii_cwt"
    t.float    "pnii_cwt"
    t.index ["orig_3zip", "dest_3zip", "weight_group_name"], name: "rates_od_wtgroup_idx", using: :btree
  end

  create_table "transits", force: :cascade do |t|
    t.text     "origin_state"
    t.text     "dest_state"
    t.integer  "days"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "zip_codes", force: :cascade do |t|
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "city"
    t.string   "state"
  end

end
