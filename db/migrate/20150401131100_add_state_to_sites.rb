class AddStateToSites < ActiveRecord::Migration
  def change
    add_column :sites, :state, :integer, default: 0
  end
end
