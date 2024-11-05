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

ActiveRecord::Schema[7.2].define(version: 2024_11_02_193848) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "amenities", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities_hotels", id: false, force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.bigint "amenity_id", null: false
    t.index ["amenity_id", "hotel_id"], name: "index_amenities_hotels_on_amenity_id_and_hotel_id"
    t.index ["hotel_id", "amenity_id"], name: "index_amenities_hotels_on_hotel_id_and_amenity_id"
  end

  create_table "block_rooms", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "reason"
    t.date "finished_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_block_rooms_on_room_id"
  end

  create_table "cancellation_reasons", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "location"
    t.string "email"
    t.string "telephone"
    t.string "description"
    t.integer "total_rooms"
    t.integer "floors"
    t.integer "max_rooms_per_floor"
    t.string "address_zip_code", limit: 9
    t.string "address_state", limit: 2
    t.string "address_city"
    t.string "address_neighborhood"
    t.string "address_street"
    t.string "address_number"
    t.string "address_complement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.string "payment_method"
    t.string "installments"
    t.string "boleto_barcode"
    t.string "pix_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_value_cents", default: 0, null: false
    t.string "total_value_currency", default: "BRL", null: false
    t.index ["reservation_id"], name: "index_payments_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.bigint "room_id", null: false
    t.string "reservation_code", null: false
    t.date "check_in_date", null: false
    t.date "check_out_date", null: false
    t.string "status", default: "reserved", null: false
    t.bigint "cancellation_reason_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "daily_price_cents", default: 0, null: false
    t.string "daily_price_currency", default: "BRL", null: false
    t.integer "total_daily_cents", default: 0, null: false
    t.string "total_daily_currency", default: "BRL", null: false
    t.text "cancellation_notes"
    t.datetime "canceled_at"
    t.bigint "canceled_by_user_id"
    t.index ["canceled_by_user_id"], name: "index_reservations_on_canceled_by_user_id"
    t.index ["cancellation_reason_id"], name: "index_reservations_on_cancellation_reason_id"
    t.index ["hotel_id"], name: "index_reservations_on_hotel_id"
    t.index ["room_id"], name: "index_reservations_on_room_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "room_number"
    t.integer "floor_number"
    t.string "description"
    t.string "status", default: "available"
    t.bigint "hotel_id", null: false
    t.bigint "room_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "daily_price_cents", default: 0, null: false
    t.string "daily_price_currency", default: "BRL", null: false
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id"
    t.index ["room_type_id"], name: "index_rooms_on_room_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "role", default: "client", null: false
    t.string "identification", limit: 18
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "block_rooms", "rooms"
  add_foreign_key "payments", "reservations"
  add_foreign_key "reservations", "cancellation_reasons"
  add_foreign_key "reservations", "hotels"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "reservations", "users", column: "canceled_by_user_id"
  add_foreign_key "rooms", "hotels"
  add_foreign_key "rooms", "room_types"
end
