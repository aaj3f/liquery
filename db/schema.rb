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

ActiveRecord::Schema.define(version: 2019_03_01_145005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drinks", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "preparation"
    t.text "image"
    t.boolean "test_drink", default: false
  end

  create_table "flavor_profiles", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: :cascade do |t|
    t.text "name"
    t.bigint "flavor_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["flavor_profile_id"], name: "idx_16429_index_ingredients_on_flavor_profile_id"
  end

  create_table "measures", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "drink_id"
    t.bigint "ingredient_id"
    t.float "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "measurement_type"
    t.index ["drink_id"], name: "idx_16445_index_measures_on_drink_id"
    t.index ["ingredient_id"], name: "idx_16445_index_measures_on_ingredient_id"
  end

  create_table "quiz_ratings", force: :cascade do |t|
    t.bigint "drink_id"
    t.bigint "quiz_id"
    t.bigint "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["drink_id"], name: "idx_16460_index_quiz_ratings_on_drink_id"
    t.index ["quiz_id"], name: "idx_16460_index_quiz_ratings_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "flavor_profile_id"
    t.boolean "use_previous_ratings", default: false
    t.bigint "recommendation"
    t.index ["user_id"], name: "idx_16453_index_quizzes_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "drink_id"
    t.bigint "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "recommended", default: false
    t.index ["drink_id"], name: "idx_16413_index_ratings_on_drink_id"
    t.index ["user_id"], name: "idx_16413_index_ratings_on_user_id"
  end

  create_table "users", id: :bigint, default: nil, force: :cascade do |t|
    t.text "email", default: ""
    t.text "encrypted_password", default: ""
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "admin_access", default: false
    t.text "provider"
    t.text "uid"
    t.text "image"
    t.index ["email"], name: "idx_16436_index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "idx_16436_index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ingredients", "flavor_profiles", name: "ingredients_flavor_profile_id_fkey"
  add_foreign_key "quiz_ratings", "drinks", name: "quiz_ratings_drink_id_fkey"
  add_foreign_key "quiz_ratings", "quizzes", name: "quiz_ratings_quiz_id_fkey"
  add_foreign_key "quizzes", "users", name: "quizzes_user_id_fkey"
  add_foreign_key "ratings", "drinks", name: "ratings_drink_id_fkey"
  add_foreign_key "ratings", "users", name: "ratings_user_id_fkey"
end
