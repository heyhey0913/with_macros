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

ActiveRecord::Schema.define(version: 2020_09_21_082520) do

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.float "total_calorie"
    t.float "protein_ratio"
    t.float "fat_ratio"
    t.float "carbohydrate_ratio"
    t.float "protein_content"
    t.float "fat_content"
    t.float "carbohydrate_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "intake_dates", force: :cascade do |t|
    t.integer "user_id"
    t.date "recorded_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_intake_dates_on_user_id"
  end

  create_table "intake_ingredients", force: :cascade do |t|
    t.integer "intake_date_id"
    t.integer "ingredient_id"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_intake_ingredients_on_ingredient_id"
    t.index ["intake_date_id"], name: "index_intake_ingredients_on_intake_date_id"
  end

  create_table "intake_recipes", force: :cascade do |t|
    t.integer "intake_date_id"
    t.integer "recipe_id"
    t.float "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intake_date_id"], name: "index_intake_recipes_on_intake_date_id"
    t.index ["recipe_id"], name: "index_intake_recipes_on_recipe_id"
  end

  create_table "progress_logs", force: :cascade do |t|
    t.integer "user_id"
    t.float "weight"
    t.float "body_fat"
    t.string "body_image_id"
    t.date "recorded_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_progress_logs_on_user_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "user_id"
    t.string "dish_name"
    t.text "method"
    t.string "dish_image_id"
    t.float "total_calorie"
    t.float "protein_ratio"
    t.float "fat_ratio"
    t.float "carbohydrate_ratio"
    t.float "protein_content"
    t.float "fat_content"
    t.float "carbohydrate_content"
    t.integer "creation_status", default: 0, null: false
    t.boolean "is_published", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "optional_id"
    t.string "nickname"
    t.string "profile_image_id"
    t.boolean "is_valid", default: true, null: false
    t.float "target_weight"
    t.float "current_weight"
    t.float "current_body_fat"
    t.float "active_factor", default: 1.2
    t.float "weekly_target_weight", default: 0.5
    t.float "daily_target_calorie"
    t.float "protein_intake_ratio"
    t.float "fat_intake_ratio"
    t.float "carbohydrate_intake_ratio"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
