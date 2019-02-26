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

ActiveRecord::Schema.define(version: 2019_02_26_193059) do

  create_table "drinks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "preparation"
    t.string "image"
    t.boolean "test_drink", default: false
  end

  create_table "flavor_profiles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "flavor_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_profile_id"], name: "index_ingredients_on_flavor_profile_id"
  end

  create_table "measures", force: :cascade do |t|
    t.integer "drink_id"
    t.integer "ingredient_id"
    t.float "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "measurement_type"
    t.index ["drink_id"], name: "index_measures_on_drink_id"
    t.index ["ingredient_id"], name: "index_measures_on_ingredient_id"
  end

  create_table "quiz_ratings", force: :cascade do |t|
    t.integer "drink_id"
    t.integer "quiz_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_quiz_ratings_on_drink_id"
    t.index ["quiz_id"], name: "index_quiz_ratings_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "flavor_profile_id"
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "drink_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_ratings_on_drink_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_access", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
