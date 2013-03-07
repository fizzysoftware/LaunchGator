require 'domainatrix'
class Site < ActiveRecord::Base
  attr_accessible :name, :user_id, :url,:tagline, :description, :twitter, :facebook, :blog, :twitter_message, :google_analytics_code, :welcome_email, :email, :domain_name, :clicks, :logo, :box_alignment, :box_visibility, :sharing_instructions, :email_subject, :business_name, :email_sender, :email_sender_name, :box_color, :name_color, :tagline_color, :description_color, :address,:image_attributes

  has_one :image
  belongs_to :user

  accepts_nested_attributes_for :image, :allow_destroy => true
  validates_presence_of :name, :url, :tagline, :email, :description
  validates_uniqueness_of :name, :unless => lambda{ |a| a.name.blank? or !a.new_record?}
  validates_uniqueness_of :url, :unless => lambda{ |a| a.url.blank? or !a.new_record?}
  validates_format_of :email,
   :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
   :unless => lambda{ |a| a.email.blank? }
   
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
 	:unless => lambda{|a| a.url.blank?}

 	def parse_domain_name_from_url
     	url = Domainatrix.parse(self.url)
     	self.domain_name = url.domain
     	self.save
  	end 

end
