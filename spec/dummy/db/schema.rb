# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150812152001) do

  create_table "acts_as_constrained_date_constraints", force: :cascade do |t|
    t.date     "starts_at"
    t.date     "ends_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "constrained_id"
    t.string   "constrained_type"
  end

  add_index "acts_as_constrained_date_constraints", ["constrained_type", "constrained_id"], name: "index_date_constraints_on_constrained_type_and_constrained_id"

  create_table "date_constraints_offers", id: false, force: :cascade do |t|
    t.integer "date_constraint_id"
    t.integer "offer_id"
  end

  add_index "date_constraints_offers", ["date_constraint_id"], name: "index_date_constraints_offers_on_date_constraint_id"
  add_index "date_constraints_offers", ["offer_id"], name: "index_date_constraints_offers_on_offer_id"

  create_table "markets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
