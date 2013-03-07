class CreateDailyReports < ActiveRecord::Migration
  def change
    create_table :daily_reports do |t|
    	t.integer :site_id
    	t.integer :views_count
    	t.integer :signups_count
    	t.string :sent_mail

      t.timestamps
    end
  end
end