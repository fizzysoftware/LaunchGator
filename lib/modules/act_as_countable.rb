module ActAsCountable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def total_records_counts_array_in_past_n_days(range = 30.days)    
      total_records = []
      counts =  self.group('Date(created_at)').count
      (30.days.ago.to_date..Date.today).each do |day|
        total_records.push((total_records.last || 0) + (counts[day] || 0))
      end
      total_records
    end
  
    def daily_records_counts_array_in_past_n_days(range = 30.days)    
      counts = self.group('Date(created_at)').count
      (range.ago.to_date..Date.today).map {|date| counts[date] || 0}
    end
  end
end
