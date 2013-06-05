class AddWordIndexToLinewords < ActiveRecord::Migration
  def change
    add_column :linewords, :word_index, :integer
  end
end
