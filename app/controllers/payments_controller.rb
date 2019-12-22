class PaymentsController < ApplicationController
  def calendar
    @bookings = Booking.all
  end

  def new
    @phone_code = ['+49', '+34', '+43']
    @booking = Booking.find(params[:booking_id])
  end

  def create
  end

  private

  def payments_params
    params.require(:order).permit(:stripeSource)
  end
end
