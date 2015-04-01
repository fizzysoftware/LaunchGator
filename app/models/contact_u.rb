class ContactU < ActiveRecord::Base
  attr_accessible :comment, :email, :name, :phone_number, :subject

  validates_presence_of :name,:email,:subject, :comment
  validates :email, :email_format => true
  validates_numericality_of :phone_number

  after_create :send_mail_to_admin

  def send_mail_to_admin
    Notifier.contact_us_mail_to_admin(self).deliver
  end

end

# == Schema Information
#
# Table name: contact_us
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  comment      :text
#  phone_number :string(255)
#  subject      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

