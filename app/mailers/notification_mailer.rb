class NotificationMailer < ApplicationMailer
  default from: 'strangerarrangerapp@gmail.com'

  def notification_email(user)
    @user = user
    puts @user.email
    mail(to: @user.email, subject: 'You have a match!')
  end
end
