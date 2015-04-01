class Invite < ActiveRecord::Base
  attr_accessible :cookie, :email, :inviter_id, :invites_count, :short_url, :site_id, :unique_code, :views_count

  has_many :referrals, :class_name=>"Invite",:foreign_key=>"inviter_id",
    :dependent => :destroy
  belongs_to :site
  belongs_to :referee, :class_name=>"Invite",:foreign_key=>"inviter_id", :counter_cache=>true

  after_create :invite_mail, :update_daily_report

  def self.get_invite_code_for_email_and_site(site_id,email,referral_code)
    invite = Invite.find_by_site_id_and_email(site_id,email)
    unless invite
      referee = Invite.find_by_unique_code(referral_code)
      invite = Invite.new(:email=>email,:site_id=>site_id)
      invite.unique_code = get_unique_code
      invite.inviter_id = referee.id if referee
      invite.cookie =  User.random_string
      invite.short_url = Invite.unique_url_generator(invite)
      invite.save
    end
    return invite
  end

  def self.get_site(code)
    referee = Invite.find_by_unique_code(code)
    return referee
  end

  def invite_mail
    Notifier.delay.invite_mail_sent(self,self.site)
  end

  def self.unique_url_generator(invite)
    unique_url = invite.site.url.to_s + "/" + invite.unique_code
    short_url =  unique_url
    return short_url
  end

  def self.get_unique_code
    unique_code = User.random_string
    while Invite.find_by_unique_code(unique_code)
      get_unique_code
    end
    return unique_code
  end

  def update_unique_code
    self.unique_code = self.class.get_unique_code
    self.short_url = site.url.to_s + "/" + unique_code
    self.save
  end

  def update_daily_report
    DailyReport.daily_sign_up_counter(self.site_id)
  end

  def inviter_email
    if self.inviter_id.blank?
      "Direct Signup "
    else
      Invite.find(self.inviter_id).email
    end
  end

  def conversion_percentage
    if self.views_count == 0
      '0.00'
    else
      (( self.invites_count.to_f / self.views_count.to_f ) * 100).round(2).to_s
    end
  end
end

# == Schema Information
#
# Table name: invites
#
#  id            :integer          not null, primary key
#  email         :string(255)
#  site_id       :integer
#  unique_code   :string(255)
#  invites_count :integer          default(0)
#  inviter_id    :integer
#  cookie        :string(255)
#  short_url     :string(255)
#  views_count   :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

