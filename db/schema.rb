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

ActiveRecord::Schema.define(:version => 20130601005001) do

  create_table "rhyming_relationships", :force => true do |t|
    t.integer  "word_id"
    t.integer  "rhyme_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rhyming_relationships", ["rhyme_id"], :name => "index_rhyming_relationships_on_rhyme_id"
  add_index "rhyming_relationships", ["word_id"], :name => "index_rhyming_relationships_on_word_id"

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.string   "original_text"
    t.string   "edited_text"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "synonym_relationships", :force => true do |t|
    t.integer  "word_id"
    t.integer  "synonym_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "synonym_relationships", ["synonym_id"], :name => "index_synonym_relationships_on_synonym_id"
  add_index "synonym_relationships", ["word_id"], :name => "index_synonym_relationships_on_word_id"

  create_table "words", :force => true do |t|
    t.string   "spelling"
    t.string   "part_of_speech"
    t.integer  "syllable_count"
    t.boolean  "checked_to_dictionary", :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

end
