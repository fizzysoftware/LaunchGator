class AddColumnsToSites < ActiveRecord::Migration
  def change
  	add_column :sites, :url, :string
  	add_column :sites, :tagline, :string
  	add_column :sites, :description, :text
  	add_column :sites, :twitter, :string
  	add_column :sites, :facebook, :string
  	add_column :sites, :blog, :string
  	add_column :sites, :twitter_message, :string
  	add_column :sites, :google_analytics_code, :text
  	add_column :sites, :welcome_email, :text
  	add_column :sites, :email, :string
  	add_column :sites, :domain_name, :string
  	add_column :sites, :clicks, :integer,:default => '0'
  	add_column :sites, :logo, :string
  	add_column :sites, :box_alignment, :string
  	add_column :sites, :box_visibility, :string
  	add_column :sites, :sharing_instructions, :text
  	add_column :sites, :email_subject, :text
  	add_column :sites, :business_name, :string
  	add_column :sites, :email_sender, :string
  	add_column :sites, :email_sender_name, :string
  	add_column :sites, :box_color, :string,:default => 'total_black'
  	add_column :sites, :name_color, :string,:default => '#ffffff'
  	add_column :sites, :tagline_color, :string,:default => '#ffffff'
  	add_column :sites, :description_color, :string,:default => '#ffffff'
  	add_column :sites, :address, :string
  end
end