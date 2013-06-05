class ChangeColumn < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.remove :original_text
      t.text :original_text, :limit => nil
    end
  end
end
