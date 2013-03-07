class DailyReport< ActiveRecord::Base
  attr_accessible :title, :body
  belongs_to :site
  

  def self.daily_view_counter(site_id)
    d = Date.today
    daily_report = DailyReport.where('site_id = ? and DATE(created_at) = ?',site_id,d ).first
    if daily_report.nil?
      daily_report =  DailyReport.new(:site_id => site_id, :views_count => 1, :signups_count => 0 )
      daily_report.save
    else
      daily_report.views_count = daily_report.views_count.to_i + 1
      daily_report.save
    end
  end

  def self.daily_sign_up_counter(site_id)
    d = Date.today
    daily_report = DailyReport.where('site_id = ? and DATE(created_at) = ?',site_id,d ).first
    unless daily_report.nil?
      daily_report.signups_count = daily_report.signups_count.to_i + 1
      daily_report.save
    end
  end

end