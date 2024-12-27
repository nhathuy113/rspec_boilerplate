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

ActiveRecord::Schema[7.1].define(version: 2023_11_21_050539) do
  create_table "body_colors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "os_versions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smartphone_models", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "manufacturer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer_id"], name: "index_smartphone_models_on_manufacturer_id"
  end

  create_table "smartphones", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "manufacturer_id", null: false
    t.bigint "smartphone_model_id", null: false
    t.bigint "memory_id", null: false
    t.bigint "year_id", null: false
    t.bigint "os_version_id", null: false
    t.bigint "body_color_id", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_color_id"], name: "index_smartphones_on_body_color_id"
    t.index ["manufacturer_id"], name: "index_smartphones_on_manufacturer_id"
    t.index ["memory_id"], name: "index_smartphones_on_memory_id"
    t.index ["os_version_id"], name: "index_smartphones_on_os_version_id"
    t.index ["smartphone_model_id"], name: "index_smartphones_on_smartphone_model_id"
    t.index ["year_id"], name: "index_smartphones_on_year_id"
  end

  create_table "years", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "smartphone_models", "manufacturers"
  add_foreign_key "smartphones", "body_colors"
  add_foreign_key "smartphones", "manufacturers"
  add_foreign_key "smartphones", "memories"
  add_foreign_key "smartphones", "os_versions"
  add_foreign_key "smartphones", "smartphone_models"
  add_foreign_key "smartphones", "years"
end
