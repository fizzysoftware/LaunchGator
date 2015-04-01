class CreateSiteUrls < ActiveRecord::Migration
  def change
    create_table :site_urls do |t|
      t.string :url
      t.boolean :active, default: false
      t.integer :site_id

      t.timestamps
    end
    add_index :site_urls, :site_id
  end
end
