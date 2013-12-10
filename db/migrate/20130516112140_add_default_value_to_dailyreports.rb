class AddDefaultValueToDailyreports < ActiveRecord::Migration
  def up
  	remove_column :daily_reports, :views_count
  	remove_column :daily_reports, :signups_count
  	add_column :daily_reports, :views_count,:integer, :default => 1
  	add_column :daily_reports, :signups_count,:integer, :default => 0
  end

  def down

  end
end
