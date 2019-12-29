class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_call.subject
  #
  def welcome(booking)
    @booking = booking
    @user = @booking.user
    # if WelcomeCall.find_by(booking_id: @booking.id)
    #   message.perform_deliveries = false
    # else
      mail(to: @user.email, subject: 'Stacey - coliving')
    # end
  end

  def welcome_call(booking)
    @booking = booking
    @user = @booking.user
    mail(to: @user.email, subject: 'Stacey - coliving - welcome call')
  end
end
