module UserAccountSetup

  def setup_user_account
    self.fetch_data_from_facebook
    self.welcome_mail
  end  
 
  def fetch_data_from_facebook
    graph = Koala::Facebook::API.new(self.oauth_token)
    self.update_details_from_facebook
    self.fetch_photo_from_facebook
  end 
  
  
    
  def update_details_from_facebook
    graph = Koala::Facebook::API.new(User.first.oauth_token)
    profile = graph.get_object("me")
    self.sex = profile['gender']
    self.city = profile['location']['name'] unless profile['location'].nil?
    self.date_of_birth = profile['birthday']
    birth_day_array = profile['birthday'].to_s.split('/')
    self.date_of_birth_month = birth_day_array[0]
    self.date_of_birth_day = birth_day_array[1]
    self.date_of_birth_year = birth_day_array[2]
    self.timezone = profile['timezone']
    self.facebook_link = profile["link"]
    self.save
  end  
  

    
  def welcome_mail
    Notifier.welcome_mail(self,self.random_password).deliver      
  end
  
 
  handle_asynchronously :setup_user_account
  handle_asynchronously :fetch_data_from_facebook
  handle_asynchronously :send_join_notifications_to_friends, :priority => 0
  handle_asynchronously :send_join_notifications_via_email, :priority => 0
  handle_asynchronously :update_details_from_facebook
  handle_asynchronously :fetch_facebook_likes_for_me_and_my_friends, :priority => 0
  handle_asynchronously :update_facebook_friends_list
  handle_asynchronously :welcome_mail, :priority => 1
  handle_asynchronously :send_welcome_gifts
  handle_asynchronously :send_a_gift_after_10_mins , :run_at => Proc.new { 10.minutes.from_now }
  handle_asynchronously :send_a_gift_after_4_days , :run_at => Proc.new { 4.days.from_now }
  handle_asynchronously :send_him_a_default_gift
  
   
end
