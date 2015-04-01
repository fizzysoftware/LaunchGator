class AddDomainPropagatedToSites < ActiveRecord::Migration
  def change
    add_column :sites, :domain_propagated, :boolean, default: 0
  end
end
