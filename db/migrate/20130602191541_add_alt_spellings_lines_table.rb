class AddAltSpellingsLinesTable < ActiveRecord::Migration
  def change
    create_table :alt_spellings_lines do |t|
      t.integer :line_id
      t.integer :alt_spelling_id

    end
    add_index :alt_spellings_lines, :line_id
    add_index :alt_spellings_lines, :alt_spelling_id
  end
end
