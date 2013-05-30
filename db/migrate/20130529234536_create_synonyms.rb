class CreateSynonyms < ActiveRecord::Migration
  def change
    create_table :synonyms do |t|
      t.integer :word_id
      t.integer :synonym_id

      t.timestamps
    end
    add_index :synonyms, :word_id
    add_index :synonyms, :synonym_id
  end
end
