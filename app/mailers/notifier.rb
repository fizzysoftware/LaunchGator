class Notifier < ActionMailer::Base
  default :from => "LaunchGator <support@deskgator.com>"

  # Default from not working. Specified individually for every mail. Mail was being sent from pintile.

  def account_activation_mail(recipient)
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "LaunchGator - Activate your Account")
  end

  def welcome(recipient)
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "Welcome to LaunchGator")
  end

  def password_recovery(recipient)
    @recipient = recipient
    mail(:to => recipient.email, :subject => "LaunchGator - Reset your Password")
  end

  def contact_us_mail_to_admin(contact_us)
    @contact_us = contact_us
    mail(:to => 'sudhanshu@fizzysoftware.com' , :subject => "LaunchGator - Contact Form", :reply_to => @contact_us.email)
  end

  def invite_mail_sent(recipient,site)
    @recipient = recipient
    @site = recipient.site

    @recipient

    url = Domainatrix.parse(@site.url)

    if @site.email_sender.nil?
      from = @site.name + "< support@" + url.domain + "." + url.public_suffix + ">"
    else
      from = @site.email_sender.to_s
    end

    if !@site.email_sender_name.nil?
      from = @site.email_sender_name.to_s + " <".to_s + from.to_s + ">".to_s
    end

    if @site.email_subject.nil?
      subject = "Thanks from " + @site.name
    else
      subject = @site.email_subject
    end

    mail(:from => from , :to => @recipient.email, :subject => subject)
  end


  def send_a_record_entry_notification_mail(site)
    @recipient = site.user
    @site = site
    mail(:to => @recipient.email, :subject => "LaunchGator - Just one more step to get started")
  end

  def send_daily_report_mail(daily_report)
    @daily_report = daily_report
    @site = @daily_report.site
    @recipient = @site.user
    subject = @site.name.to_s + "- Daily Report"
    mail(:to => @recipient.email, :subject => subject )
  end

end
