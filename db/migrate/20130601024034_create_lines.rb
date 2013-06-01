class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :stanza_id
      t.integer :max_syllables

      t.timestamps
    end
    add_index :lines, :stanza_id
  end
end
