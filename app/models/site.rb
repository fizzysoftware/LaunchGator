require 'domainatrix'
class Site < ActiveRecord::Base
  attr_accessible :name, :url,:tagline, :description, :twitter, :facebook, :blog, :twitter_message, :google_analytics_code, :welcome_email, :email, :domain_name, :logo, :box_alignment, :box_visibility, :sharing_instructions, :email_subject, :business_name, :email_sender, :email_sender_name, :box_color, :name_color, :tagline_color, :description_color, :address,:image_attributes, :site_urls_attributes, :user_id, :domain_propagated, :state

  has_one :image, :dependent => :destroy
  belongs_to :user
  has_many :invites, :dependent => :destroy
  has_many :site_urls, :dependent => :destroy
  has_many :daily_reports, :dependent => :destroy

  accepts_nested_attributes_for :image,:allow_destroy => true
  accepts_nested_attributes_for :site_urls, reject_if: :check_url_blank?, :allow_destroy => true
  validates_presence_of :name, :url, :tagline, :email, :description
  validates :name, :url, :uniqueness => true, :allow_blank => true
  validates :email, :email_format => true

   validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
   :unless => lambda{|a| a.url.blank?}

   before_save :update_email_subject
   before_update :update_state_of_status_bar

  def self.find_site_from_orignal_url(original_url)
    @url_params = Domainatrix.parse(original_url)
    @original_url = @url_params.scheme + "://" + @url_params.host
    site = find_by_url(@original_url)
    site = SiteUrl.find_site_by_url(@original_url) if site.blank?
    if site.blank?
      raise ActiveRecord::RecordNotFound.new
    else
      return site
    end
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

  def domain_mapped?
    check_url = url if !url.nil?
    `curl -I "#{check_url}"`.match('_launch_gator_session').present?
  end

  def check_url_blank?(site_urls_attributes)
    if site_urls_attributes[:url].blank?
      return true
    end
  end

  def update_state_of_status_bar
    if self.url_changed? and self.image.present?
        self.state = 2
        self.domain_propagated = 0
    elsif self.image != nil and self.domain_propagated != true
        self.state =  2
        self.domain_propagated = 0
    elsif self.url_changed?
        self.state = 1
    elsif self.url.present? and self.image != nil and self.domain_propagated != true
        self.stage = 2
    elsif self.url.present? and self.domain_propagated != true and self.image == nil
      self.state = 1
    end
  end

  def self.daily_stats
    time_range = (Time.now.midnight - 1.day)..Time.now.midnight
    @site = self.joins(:invites).where('invites.created_at' => time_range).uniq
    @site.each do |site|
    @today_invites = site.invites.where(:created_at => time_range)
    Notifier.daily_stats(@today_invites, site).deliver
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
#  domain_propagated     :boolean          default(FALSE)
#  state                 :integer          default(0)
#

