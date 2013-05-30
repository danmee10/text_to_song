class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :spelling
      t.string :part_of_speech
      t.integer :syllable_count
      t.boolean :checked_to_dictionary, default: false

      t.timestamps
    end
  end
end
