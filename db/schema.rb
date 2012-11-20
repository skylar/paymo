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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121120190936) do

  create_table "payments", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "amount"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "fb_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "cc_number"
    t.string   "cc_year"
    t.string   "cc_month"
    t.string   "bank_routing"
    t.string   "bank_account"
    t.string   "balanced_uri",   :limit => 128
    t.string   "street_address"
    t.string   "postal_code"
    t.string   "country_code"
    t.string   "dob"
    t.string   "phone_number"
  end

end
