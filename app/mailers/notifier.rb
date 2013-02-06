class Notifier < ActionMailer::Base
  default :from => "support@basic_module.com"

  def welcome_mail(recipient,random_password = "")
    @recipient = recipient
    @random_password = random_password
    mail(:to => @recipient.email, :subject => "Welcome to Gifts")  
  end
  
 
  def we_are_missing_you(recipient)
    @recipient = recipient
    mail(:to => recipient.email, :subject => "We are missing you :)")
  end 
end
