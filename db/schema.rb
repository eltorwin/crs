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

ActiveRecord::Schema[7.1].define(version: 2023_12_23_043638) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "rate", ["rub_usd", "rub_eur", "rub_cny"]

  create_table "exchange_rates", force: :cascade do |t|
    t.enum "current_rate", default: "rub_usd", null: false, enum_type: "rate"
    t.decimal "current_value", precision: 14, scale: 2, default: "0.0", null: false
    t.date "parse_at", null: false
    t.index ["current_rate", "parse_at"], name: "index_exchange_rates_on_current_rate_and_parse_at", unique: true
  end

end
