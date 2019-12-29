class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_call.subject
  #
  def welcome_call(booking)
    @booking = booking
    @user = @booking.user
    mail(to: @user.email, subject: 'Stacey - coliving - welcome call')
  end
end
