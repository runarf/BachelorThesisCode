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

ActiveRecord::Schema.define(version: 20150417164141) do

  create_table "stages", force: :cascade do |t|
    t.text     "departureStop"
    t.text     "arrivalStop"
    t.text     "departureTime"
    t.text     "arrivalTime"
    t.text     "lineName"
    t.text     "travelTime"
    t.integer  "travelType"
    t.integer  "trip_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "stages", ["trip_id"], name: "index_stages_on_trip_id"

  create_table "trips", force: :cascade do |t|
    t.float    "distance"
    t.text     "duration"
    t.text     "departure_time"
    t.text     "departure_place"
    t.text     "arrival_time"
    t.text     "arrival_place"
    t.integer  "transfers"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
