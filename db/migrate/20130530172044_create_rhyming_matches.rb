class CreateRhymingMatches < ActiveRecord::Migration
  def change
    create_table :rhyming_matches do |t|
      t.integer :word_id
      t.integer :rhyming_match_id

      t.timestamps
    end
    add_index :rhyming_matches, :word_id
    add_index :rhyming_matches, :rhyming_match_id
  end
end
