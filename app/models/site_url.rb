class SiteUrl < ActiveRecord::Base
  attr_accessible :active, :site_id, :url

  belongs_to :site

  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
   :unless => lambda{|a| a.url.blank?}
  validates :url, :uniqueness => true, :allow_blank => true

   #  ====================
   #  = Instance Methods =
   #  ====================

   def activate_url
      update_attribute(:active, true)
   end

   #  =================
   #  = Class Methods =
   #  =================

   def self.find_site_by_url(original_url)
      site_url = find_by_url(original_url)
      if site_url.present?
        site_url.activate_url
        site = site_url.site
      end
   end
end

# == Schema Information
#
# Table name: site_urls
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  active     :boolean          default(FALSE)
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

