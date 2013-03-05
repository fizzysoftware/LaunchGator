class RenameFullNameToUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :name, :full_name
  	add_column :users, :account_type, :string, :default => 'user'
  end

  def down
  	rename_column :users, :full_name, :name
  	remove_column :users, :account_type
  end
end
