class Notifier < ActionMailer::Base
  default :from => "LaunchGator <support@launch.deskgator.com>"

  # Default from not working. Specified individually for every mail. Mail was being sent from pintile.

  def account_activation_mail(recipient)
    from = "LaunchGator <support@launch.deskgator.com>"
    @recipient = recipient
    mail(:from => from ,:to => @recipient.email, :subject => "LaunchGator - Activate your Account")
  end

  def welcome(recipient)
    from = "LaunchGator <support@launch.deskgator.com>"
    @recipient = recipient
    mail(:from => from ,:to => @recipient.email, :subject => "Welcome to LaunchGator")
  end

  def password_recovery(recipient)
    from = "LaunchGator <support@launch.deskgator.com>"
    @recipient = recipient
    mail(:from => from ,:to => recipient.email, :subject => "LaunchGator - Reset your Password")
  end

  def contact_us_mail_to_admin(contact_us)
    from = "LaunchGator <support@launch.deskgator.com>"
    @contact_us = contact_us
    mail(:from => from ,:to => 'sudhanshu@fizzysoftware.com' , :subject => "LaunchGator - Contact Form")
  end

  def invite_mail_sent(recipient,site)
    @recipient = recipient
    @site = recipient.site

    p @recipient

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
    from = "LaunchGator <support@launch.deskgator.com>"
    @recipient = site.user
    @site = site
    mail(:from => from ,:to => @recipient.email, :subject => "LaunchGator - Just one more step to get started")
  end  

  def send_daily_report_mail(daily_report)
    from = "LaunchGator <support@launch.deskgator.com>"
    @daily_report = daily_report
    @site = @daily_report.site
    @recipient = @site.user
    subject = @site.name.to_s + "- Daily Report"
    mail(:from => from ,:to => @recipient.email, :subject => subject )
  end

end
