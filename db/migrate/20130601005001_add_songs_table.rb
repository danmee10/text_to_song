class AddSongsTable < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :original_text
      t.string :edited_text

      t.timestamps
    end
  end
end
