class BookingsController < ApplicationController
  def calendar
    @bookings = Booking.all
  end
end
