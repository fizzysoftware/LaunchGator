class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
