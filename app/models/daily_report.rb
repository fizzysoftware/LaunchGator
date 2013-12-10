class DailyReport< ActiveRecord::Base
  belongs_to :site
  
  def self.daily_view_counter(site_id)
    date = Date.today
    daily_report = DailyReport.where('site_id = ? and DATE(created_at) = ?',site_id,date ).first
    if daily_report.nil?
      daily_report =  DailyReport.new(:site_id => site_id)
      daily_report.save
    else
      daily_report.views_count = daily_report.views_count.to_i + 1
      daily_report.save
    end
  end

  def self.daily_sign_up_counter(site_id)
    date = Date.today
    daily_report = DailyReport.where('site_id = ? and DATE(created_at) = ?',site_id,date ).first
    unless daily_report.nil?
      daily_report.signups_count = daily_report.signups_count.to_i + 1
      daily_report.save
    end
  end

end

# == Schema Information
#
# Table name: daily_reports
#
#  id            :integer          not null, primary key
#  site_id       :integer
#  sent_mail     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  views_count   :integer          default(1)
#  signups_count :integer          default(0)
#

