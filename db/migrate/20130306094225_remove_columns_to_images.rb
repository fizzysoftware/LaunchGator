class RemoveColumnsToImages < ActiveRecord::Migration
  def up
  	remove_column :images, :attachment_content_type
  	remove_column :images, :imageable_id
  	remove_column :images, :imageable_type
  	remove_column :images, :title
  end

  def down
  end
end
