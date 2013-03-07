class Invite < ActiveRecord::Base
  attr_accessible :cookie, :email, :inviter_id, :invites_count, :short_url, :site_id, :unique_code, :views_count

  has_many :referrals, :class_name=>"Invite",:foreign_key=>"inviter_id"
  belongs_to :site
  belongs_to :referee, :class_name=>"Invite",:foreign_key=>"inviter_id", :counter_cache=>true
  after_create :invite_mail, :update_daily_report

  def self.get_invite_code_for_email_and_site(site_id,email,referral_code)
    invite = Invite.find_by_site_id_and_email(site_id,email)
    unless invite
      referee = Invite.find_by_unique_code(referral_code)
      invite = Invite.new(:email=>email,:site_id=>site_id)
      invite.unique_code = get_unique_code
      invite.inviter_id = referee.id if referee
      invite.cookie =  User.random_string  
      invite.short_url = Invite.unique_url_generator(invite)
      invite.save
    end  
    return invite
  end 


  def self.get_site(code)
    referee = Invite.find_by_unique_code(code)
    return referee
  end  


  def invite_mail
    Notifier.invite_mail_sent(self,self.site).deliver   
  end    

  def self.unique_url_generator(invite)
    unique_url = invite.site.url.to_s + "/" + invite.unique_code
    short_url =  unique_url
    return short_url
  end  


  def self.random_string_three_chars
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a
    newpass = ""
    1.upto(3) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end


  def self.random_string_three_integers
    #generate a random password consisting of strings and digits
    chars =  ("0".."9").to_a
    newpass = ""
    1.upto(3) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def self.get_unique_code
    unique_code = random_string_three_chars + random_string_three_integers.to_s
    while Invite.find_by_unique_code(unique_code)
      get_unique_code
    end
    return unique_code  
  end
  
  def update_daily_report
     DailyReport.daily_sign_up_counter(self.site_id)
  end

  def inviter_email
    if self.inviter_id.blank?
      "Direct Referral "
    else
      Invite.find(self.inviter_id).email
    end
  end

  def conversion_percentage
    if self.views_count == 0
      '0.00'
    else
      (( self.invites_count.to_f / self.views_count.to_f ) * 100).round(2).to_s
    end
  end
end