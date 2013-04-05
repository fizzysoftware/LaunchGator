class AddColumnsToImages < ActiveRecord::Migration
  def change
  	add_column :images, :site_id, :integer
  	add_column :images, :logo_file_name, :string
  	add_column :images, :logo_file_size, :string
  	add_column :images, :logo_updated_at, :string
  	add_column :images, :background_file_name, :string
  	add_column :images, :background_file_size, :string
  	add_column :images, :background_updated_at, :string
  	remove_column :images, :attachment_file_name
  	remove_column :images, :attachment_file_size
  end
end
