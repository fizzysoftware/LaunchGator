module Reminders
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def send_reminders
      self.no_login_in_last_5_days
      self.no_login_in_last_15_days
      self.no_login_in_last_30_days
    end
      
    def no_login_in_last_5_days
      self.where("Date(created_at) = ? and Date(last_sign_in_at) < ?", (Date.today - 5.days), (Date.today - 2.days)).find_each do |user|
        user.we_are_missing_you
      end  
    end
  
    def no_login_in_last_15_days   
      self.where("Date(created_at) = ? and Date(last_sign_in_at) < ?", (Date.today - 15.days), (Date.today - 8.days)).find_each do |user|
        user.we_are_missing_you
      end 
    end
    
    def no_login_in_last_30_days   
      self.where("Date(created_at) = ? and Date(last_sign_in_at) < ?", (Date.today - 30.days), (Date.today - 15.days)).find_each do |user|
        user.we_are_missing_you
      end 
    end
    
  end
  
  
  def we_are_missing_you
    Notifier.we_are_missing_you(self).deliver      
  end  
  
  handle_asynchronously :we_are_missing_you
end
