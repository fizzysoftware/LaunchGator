class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :timeoutable , :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :full_name,:account_type
  validates_presence_of :full_name, :email
  validates :email, :email_format => true
 
  has_one :site

  after_create :welcome_mail
  after_create :create_first_website , :unless => lambda{ |a| a.account_type == 'super_admin' }

  def welcome_mail
    Notifier.welcome(self).deliver
  end

  def create_first_website 
    site_url = 'http://' + self.full_name.delete(" ").to_s + ".com"
    @site = Site.new
    @site.user_id = self.id
    @site.email = self.email 
    
    @site.sharing_instructions = "Invite at least 3 friends using the link below. The more friends you invite, the sooner you'll get access!<br>To share with your friends, click 'Recommend' or 'Tweet'"
    
    @site.email_sender = self.email
    @site.email_subject = 'Welcome to ' +  site_url
    @site.welcome_email = "Thanks for signing up!     \r\n\r\nInvite more friends via Facebook, Twitter or email to get early access by sharing your unique link %share_referral_link%."
    
    @site.save(:validate=>false)  
  end

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.random_string
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(10) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end    

  # def facebook_photo_url(type = 'large')
  #   return if self.uid.blank?
  #   "http://graph.facebook.com/" + self.uid.to_s + "/picture?type=" + type
  # end

  # def photo_from_url(url)
  #   temp_file =  open(URI.encode(url))
  #   def temp_file.original_filename; base_uri.path.split('/').last; end
  #   self.photo = temp_file
  # end

  # def fetch_photo_from_facebook
  #   return if self.uid.blank?
  #   url = "http://graph.facebook.com/" + self.uid + "/picture?type=large"
  #   self.photo_from_url(url)
  #   self.save
  # end

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.full_name = auth.info.name
  #     user.email = auth.info.email
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #   end
  # end
end
