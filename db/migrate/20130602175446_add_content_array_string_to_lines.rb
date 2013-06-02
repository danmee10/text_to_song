class AddContentArrayStringToLines < ActiveRecord::Migration
  def change
    add_column :lines, :content_array_string, :string
  end
end
