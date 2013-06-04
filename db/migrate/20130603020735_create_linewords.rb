class CreateLinewords < ActiveRecord::Migration
  def change
    create_table :linewords do |t|
      t.integer :line_id
      t.integer :word_id

    end
    add_index :linewords, :line_id
    add_index :linewords, :word_id
  end
end
