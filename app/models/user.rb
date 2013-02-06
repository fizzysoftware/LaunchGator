# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  uid              :string(255)
#  provider         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  include ActAsCountable
  include UserAccountSetup
  include Reminders
  
  # Include default devise modules. Others available are:
  #
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :timeoutable , :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :name
  validates_presence_of :name, :email
  validates :email, :email_format => true
 # validates :username, :format => { :with => /^(?!_)(?:[a-z0-9]_?)*[a-z](?:_?[a-z0-9])*(?<!_)$/i }, :uniqueness => true
  has_one :image, :as => :imageable, :order => "created_at DESC"

  after_create :welcome_mail

  def welcome_mail
    Notifier.welcome(self).deliver
  end

  def facebook_photo_url(type = 'large')
    return if self.uid.blank?
    "http://graph.facebook.com/" + self.uid.to_s + "/picture?type=" + type
  end

  def photo_from_url(url)
    temp_file =  open(URI.encode(url))
    def temp_file.original_filename; base_uri.path.split('/').last; end
    self.photo = temp_file
  end

  def fetch_photo_from_facebook
    return if self.uid.blank?
    url = "http://graph.facebook.com/" + self.uid + "/picture?type=large"
    self.photo_from_url(url)
    self.save
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

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
  end
end
