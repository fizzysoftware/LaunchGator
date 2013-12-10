class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :full_name,:account_type

  validates_presence_of :full_name, :email
  validates :email, :email_format => true

  has_one :site , :dependent => :destroy

  after_create :welcome_mail
  after_create :create_website , :unless => lambda{ |a| a.account_type == 'super_admin' }

  def welcome_mail
    Notifier.welcome(self).deliver
  end

  def create_website
    #site_url = 'http://' + self.full_name.delete(" ").to_s + ".com"
    site = Site.new
    site.user_id = self.id
    site.email = self.email

    site.sharing_instructions = "Invite at least 3 friends using the link below. The more friends you invite, the sooner you'll get access!<br>To share with your friends, click 'Recommend' or 'Tweet'"

    site.email_sender = self.email
    site.email_subject = 'Welcome to LaunchGator'
    site.welcome_email = "Thanks for signing up!     \r\n\r\nInvite more friends via Facebook, Twitter or email to get early access by sharing your unique link %share_referral_link%."
    site.url = "http://"
    site.save(:validate=>false)
  end

  def self.random_string
    #generate a random password consisting of strings and digits
    # chars = ("a".."z").to_a + ("A".."Z").to_a #+ ("0".."9").to_a
    # newpass = ""
    # 1.upto(10) { |i| newpass << chars[rand(chars.size-1)] }
    # return newpass
    [*'a'..'z', *'A'..'Z'].sample(3).join + (0..9).to_a.sample(3).join
  end


end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  full_name              :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  uid                    :string(255)
#  provider               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  authentication_token   :string(255)
#  username               :string(255)
#  account_type           :string(255)      default("user")
#  active                 :integer
#

