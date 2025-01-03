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

ActiveRecord::Schema[7.1].define(version: 2025_01_03_000003) do
  create_table "body_colors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "model_options", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "smartphone_model_id", null: false
    t.bigint "body_color_id", null: false
    t.bigint "memory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_color_id"], name: "index_model_options_on_body_color_id"
    t.index ["memory_id"], name: "index_model_options_on_memory_id"
    t.index ["smartphone_model_id"], name: "index_model``_options_on_smartphone_model_id"
  end

  create_table "os_versions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smartphone_models", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "year_id", null: false
    t.bigint "os_version_id", null: false
    t.bigint "brand_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_smartphone_models_on_brand_id"
    t.index ["os_version_id"], name: "index_smartphone_models_on_os_version_id"
    t.index ["year_id"], name: "index_smartphone_models_on_year_id"
  end

  create_table "smartphone_options", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "smartphone_id", null: false
    t.bigint "model_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_option_id"], name: "index_smartphone_options_on_model_option_id"
    t.index ["smartphone_id"], name: "index_smartphone_options_on_smartphone_id"
  end

  create_table "smartphones", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "smartphone_model_id", null: false
    t.index ["smartphone_model_id"], name: "index_smartphones_on_smartphone_model_id"
  end

  create_table "years", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "model_options", "body_colors"
  add_foreign_key "model_options", "memories"
  add_foreign_key "model_options", "smartphone_models"
  add_foreign_key "smartphone_models", "brands"
  add_foreign_key "smartphone_models", "os_versions"
  add_foreign_key "smartphone_models", "years"
  add_foreign_key "smartphone_options", "model_options"
  add_foreign_key "smartphone_options", "smartphones"
  add_foreign_key "smartphones", "smartphone_models"
end
