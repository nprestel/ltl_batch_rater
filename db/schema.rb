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

ActiveRecord::Schema.define(version: 20161123032346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ltl_discounts", force: :cascade do |t|
    t.string   "carrier_scac"
    t.string   "origin_state"
    t.string   "dest_state"
    t.decimal  "discount",     precision: 5, scale: 2
    t.decimal  "min",          precision: 5, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "group"
  end

  create_table "rates", force: :cascade do |t|
    t.string   "carrier_scac"
    t.float    "nmfc_class"
    t.string   "orig_3zip"
    t.string   "dest_3zip"
    t.string   "weight_break"
    t.float    "cwt"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "zip_codes", force: :cascade do |t|
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
