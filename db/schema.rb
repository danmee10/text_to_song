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

ActiveRecord::Schema.define(:version => 20130530172044) do

  create_table "rhyming_matches", :force => true do |t|
    t.integer  "word_id"
    t.integer  "rhyming_match_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "rhyming_matches", ["rhyming_match_id"], :name => "index_rhyming_matches_on_rhyming_match_id"
  add_index "rhyming_matches", ["word_id"], :name => "index_rhyming_matches_on_word_id"

  create_table "synonyms", :force => true do |t|
    t.integer  "word_id"
    t.integer  "synonym_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "synonyms", ["synonym_id"], :name => "index_synonyms_on_synonym_id"
  add_index "synonyms", ["word_id"], :name => "index_synonyms_on_word_id"

  create_table "words", :force => true do |t|
    t.string   "spelling"
    t.string   "part_of_speech"
    t.integer  "syllable_count"
    t.boolean  "checked_to_dictionary", :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

end