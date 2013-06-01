class CreateStanzas < ActiveRecord::Migration
  def change
    create_table :stanzas do |t|
      t.integer :song_id
      t.integer :max_lines

      t.timestamps
    end
    add_index :stanzas, :song_id
  end
end
