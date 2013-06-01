class AddLinesWordsJoinTable < ActiveRecord::Migration
  def change
    create_table :lines_words do |t|
      t.integer :line_id
      t.integer :word_id

    end
    add_index :lines_words, :line_id
    add_index :lines_words, :word_id
  end
end
