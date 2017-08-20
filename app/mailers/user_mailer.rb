class UserMailer < ApplicationMailer
  default from: 'admin@timetrack.com'
  layout 'mailer'

  def deleted_email(user)
    @user = user
    mail(to: @user.email, subject: "Your account has been removed.")
  end
end
