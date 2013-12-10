class Image < ActiveRecord::Base
  attr_accessible :logo,:background

  belongs_to :site
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>",:facebook_meta_tag => "200x200#" }
  has_attached_file :background 
  
  def update_colums(params)   
    if params[:logo_destroy] && params[:logo_destroy].to_s == 'on'
      self.logo_file_name = nil
    end
    if params[:background_destroy] && params[:background_destroy].to_s == 'on' 
      self.background_file_name = nil
    end
    self.save
  end
  
end

# == Schema Information
#
# Table name: images
#
#  id                    :integer          not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  site_id               :integer
#  logo_file_name        :string(255)
#  logo_file_size        :string(255)
#  logo_updated_at       :string(255)
#  background_file_name  :string(255)
#  background_file_size  :string(255)
#  background_updated_at :string(255)
#

