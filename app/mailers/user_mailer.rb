class UserMailer < ActionMailer::Base
  default from: "jojoleczek@o2.pl"

  def expire_email(user)
    mail(to: user.email, subject: "Subscription Cancelled")    
  end
end
