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

ActiveRecord::Schema.define(version: 20160727201302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keywords", force: :cascade do |t|
    t.string   "keyword"
    t.text     "cache"
    t.string   "processed_at"
    t.integer  "total_results"
    t.float    "search_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "report_id"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "url"
    t.boolean  "isTopAd"
    t.boolean  "isRightAd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "keyword_id"
  end

end
