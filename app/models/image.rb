# == Schema Information
#
# Table name: images
#
#  id                      :integer          not null, primary key
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  imageable_id            :integer
#  imageable_type          :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Image < ActiveRecord::Base
  attr_accessible :title, :attachment_content_type, :attachment_file_name, :attachment_file_size, :imageable_id, :imageable_type, :attachment
  #has_attached_file :attachment, :styles => { :medium => "300>", :thumb => "200>" }

  has_attached_file :attachment, styles: lambda {
    |attachment| {
      thumb: (
      attachment.instance.imageable_type.eql?("Movie") ? ["500>", 'jpg'] :  ["300>", 'jpg']
      ),
      medium: (
      attachment.instance.imageable_type.eql?("Movie") ? ["700>", 'jpg'] :  ["500>", 'jpg']
      ),
      facebook_meta_tag: (["200x200#", :jpg])
    }
  },
  :convert_options => {
    :medium => "-quality 80 -interlace Plane",
    :thumb => "-quality 80 -interlace Plane",
    :facebook_meta_tag => "-quality 80 -interlace Plane"
  },
  :s3_headers => { 'Cache-Control' => 'max-age=315576000', 'Expires' => 10.years.from_now.httpdate }

  belongs_to :imageable, :polymorphic => true
end

