require 'domainatrix'
class Site < ActiveRecord::Base
  attr_accessible :name, :url,:tagline, :description, :twitter, :facebook, :blog, :twitter_message, :google_analytics_code, :welcome_email, :email, :domain_name, :logo, :box_alignment, :box_visibility, :sharing_instructions, :email_subject, :business_name, :email_sender, :email_sender_name, :box_color, :name_color, :tagline_color, :description_color, :address,:image_attributes, :user_id

  has_one :image, :dependent => :destroy
  belongs_to :user
  has_many :invites, :dependent => :destroy
  has_many :daily_reports, :dependent => :destroy

  accepts_nested_attributes_for :image, :allow_destroy => true
  validates_presence_of :name, :url, :tagline, :email, :description
  # validates_uniqueness_of :name, :unless => lambda{ |a| a.name.blank? or !a.new_record?}
  # validates_uniqueness_of :url, :unless => lambda{ |a| a.url.blank? or !a.new_record?}
  validates :name, :url, :uniqueness => true, :allow_blank => true
  validates :email, :email_format => true

   validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
 	 :unless => lambda{|a| a.url.blank?}

   before_save :update_email_subject

  def self.find_site_from_orignal_url(original_url)
    @url_params = Domainatrix.parse(original_url)
    @original_url = @url_params.scheme + "://" + @url_params.host
    find_by_url!(@original_url)
  end


  def parse_domain_name_from_url
    url = Domainatrix.parse(self.url)
    self.domain_name = url.domain
    self.save
  end

  def update_email_subject
    if self.email_subject_changed?
      self.email_subject = self.email_subject
    elsif self.name_changed? and !self.email_subject_changed?
      if self.email_subject_was == "Welcome To #{self.name_was}" or self.email_subject_was == "Welcome to LaunchGator"
        self.email_subject = "Welcome To #{self.name}"
      else
        self.email_subject = self.email_subject
      end
    end
  end


end

# == Schema Information
#
# Table name: sites
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  url                   :string(255)
#  tagline               :string(255)
#  description           :text
#  twitter               :string(255)
#  facebook              :string(255)
#  blog                  :string(255)
#  twitter_message       :string(255)
#  google_analytics_code :text
#  welcome_email         :text
#  email                 :string(255)
#  domain_name           :string(255)
#  clicks                :integer          default(0)
#  logo                  :string(255)
#  box_alignment         :string(255)
#  box_visibility        :string(255)
#  sharing_instructions  :text
#  email_subject         :text
#  business_name         :string(255)
#  email_sender          :string(255)
#  email_sender_name     :string(255)
#  box_color             :string(255)      default("total_black")
#  name_color            :string(255)      default("#ffffff")
#  tagline_color         :string(255)      default("#ffffff")
#  description_color     :string(255)      default("#ffffff")
#  address               :string(255)
#

