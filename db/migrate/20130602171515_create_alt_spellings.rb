class CreateAltSpellings < ActiveRecord::Migration
  def change
    create_table :alt_spellings do |t|
      t.string :alt_spelling
      t.integer :word_id

      t.timestamps
    end
    add_index :alt_spellings, :word_id
  end
end
