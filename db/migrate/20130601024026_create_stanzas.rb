class CreateStanzas < ActiveRecord::Migration
  def change
    create_table :stanzas do |t|

      t.timestamps
    end
  end
end
