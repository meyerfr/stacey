class WelcomeCallsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_booking_auth_token!, only: [:book, :useredit]

  # neccessary actions:
    # admin actions
    # index(to see the booked and upcoming calls) this is actually a list,

    # To Update Job (probably not in this controller)
    # Job automatically creates WelcomeCall instances every week for given timeslots
    # edit_job()
    # update_job()

    # user actions
    # edit(to book an availble timeslot) all WelcomeCalls timeslots must be shown
    # update(to do WelcomeCall.update(available: false, user_id: params[:user_id]))

    # destroy(for user and admin, if admin cancels user gets appologize_mail, if user cancels send slack message)
    # think about: when admin cancels, send new timeslot suggestion or just link to select a new one

  # index view is the view where the user can choose a slot for his/her welcome call
  def index
    # @welcome_calls = WelcomeCall.all.where(available: false)
    period_param = params[:period] if params[:period]
    search_param = params[:search] if params[:search]
    # if search and period
    @welcome_calls = WelcomeCall.all.where("start_time >= ? AND available = ?", Time.now, false)

    if period_param == 'upcoming'
      @welcome_calls = WelcomeCall.all.where("start_time >= ? AND available = ?", Time.now, false)
    elsif period_param == 'past'
      @welcome_calls = WelcomeCall.all.where("start_time < ? AND available = ?", Time.now, false)
    end

    if search_param
      @welcome_calls = WelcomeCall.all.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # if search_param && period_param
    #   if period_param == 'upcoming' # all upcoming calls
    #     @welcome_calls = WelcomeCall.all.where("start_time >= ? AND available = ? AND lower(name) = ?", Time.now, false, search_param.downcase) if search_param
    #   else # all past calls
    #     @welcome_calls = WelcomeCall.all.where("start_time < ? AND available = ? AND lower(name) = ?", Time.now, false, search_param.downcase) if search_param
    #   end
    # elsif search_param
    #   @welcome_calls = WelcomeCall.all.where("lower(name) = ?", search_param.downcase)
    # end

    @dates = []
    @welcome_calls.each { |call| @dates << call.start_time.to_date unless @dates.include?(call.start_time.to_date) }
    # @date = params[:date].to_date if present?
    # @month_param = params[:month] ? "#{params[:month]}-01".to_date : Date.today
    # @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  # def new
  #   @welcome_call = WelcomeCall.new
  # end

  # def create
  #   @welcome_call = WelcomeCall.new(welcome_calls_params)
  # end

  def book
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    booked_welcome_call_times = []
    WelcomeCall.all.where("start_time > ? AND available = ?", Date.today, false).each{ |call| booked_welcome_call_times << call.start_time }
    @available_times = array_of_dates(booked_welcome_call_times)
    # @welcome_calls = WelcomeCall.all.where("start_time > ? AND start_time < ? AND available = ?", (Date.today + 1.day), (Date.today + 9.days), true)

    date_params = params[:date].to_date if params[:date]
    if date_params && date_params < Date.today + 9.days
      if @available_times.find(date_params.all_day).any?
        @date = date_params
      else
        next_helper = @available_times.select { |available_time| available_time > date_params }
        @date = next_helper.any? ? next_helper.first.to_date : Date.today
      end
    else
      @date = @available_times.select { |available_time| available_time > Date.today}.first.to_date
    #   if @welcome_calls.where("start_time = ?", params[:date].to_date).any?
    #     @date = params[:date].to_date
    #   else
    #     next_helper = @welcome_calls.where("start_time > ?", params[:date].to_date)
    #     @date = next_helper.any? ? next_helper.first.start_time.to_date : Date.today
    #   end
    # else
    #   @date = @welcome_calls.where("start_time > ?", Date.today).first.start_time.to_date
    end

    # @date = params[:date].present? ? params[:date].to_date : Date.today
    # welcome calls on that date
    @date_available_times = @available_times.select { |available_time| available_time.to_date == @date } if @available_times.select { |available_time| available_time.to_date == @date }.length.positive?
    # @date_welcome_calls = @welcome_calls.where(start_time: @date.all_day) if @welcome_calls.where(start_time: @date.all_day).length.positive?

    @month_helper = params[:month].to_date if params[:month]
    @month_param = params[:month] && Date.today <= @month_helper && @month_helper <= Date.today + 9.days ? @month_helper : Date.today
    # @month_param = params[:month] ? "#{params[:month]}-01".to_date : Date.today
    @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  def update
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @welcome_call = WelcomeCall.find(params[:id])
    if @welcome_call.booking.nil?
      if @welcome_call.update(available: false, booking_id: @booking.id, name: @user.full_name)
        # Send email with all the information
        UserMailer.welcome_call(@booking).deliver_now
        flash[:alert] = "We just send you an email with all informations."
        redirect_to :root
      else
        flash[:alert] = "Oops, something wrent wrong. Please try it again."
        redirect_to booking_book_welcome_call_path(@booking.booking_auth_token, @booking)
      end
    else
      flash[:alert] = "Your call is already scheduled for the #{WelcomeCall.find_by(booking_id: @booking.id).start_time.strftime('%d.%B %Y')}. Please check your mails."
      # redirect to welcome_call#edit page
      redirect_to booking_book_welcome_call_path(@booking.booking_auth_token, @booking)
    end
  end

  def useredit
    @old_welcome_call = WelcomeCall.find(params[:id])
    @booking = @old_welcome_call.booking
    @welcome_calls = WelcomeCall.all.where("start_time > ? AND start_time < ? AND available = ?", (Date.today + 1.day), (Date.today + 9.days), true)
    if params[:date] && params[:date].to_date < Date.today + 9.days
      if @welcome_calls.where("start_time = ?", params[:date].to_date).any?
        @date = params[:date].to_date
      else
        next_helper = @welcome_calls.where("start_time > ?", params[:date])
        @date = next_helper.any? ? next_helper.first.start_time.to_date : Date.today
      end
    else
      @date = @welcome_calls.where("start_time > ?", Date.today).first.start_time.to_date
    end

    # @date = params[:date].present? ? params[:date].to_date : Date.today
    # welcome calls on that date
    @date_welcome_calls = @welcome_calls.where(start_time: @date.all_day) if @welcome_calls.where(start_time: @date.all_day).length.positive?

    @month_helper = params[:month].to_date if params[:month]
    @month_param = params[:month] && Date.today <= @month_helper && @month_helper <= Date.today + 9.days ? @month_helper : Date.today
    # @month_param = params[:month] ? "#{params[:month]}-01".to_date : Date.today
    @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  def userupdate
    @old_welcome_call = WelcomeCall.find(params[:old_id])
    @new_welcome_call = WelcomeCall.find(params[:id])
    @booking = @welcome_call.booking
    @user = @booking.user
    if @new_welcome_call.update(available: false, booking_id: @booking.id, name: @user.full_name)
      flash[:alert] = 'Our call has been reschedueled. Please check your mails'
      redirect_to root_path
    else
      flash[:alert] = "Oops, something wrent wrong. Please try it again."
      redirect_to booking_useredit_welcome_call(@booking.booking_auth_token, @booking, @old_welcome_call)
    end
  end

  def cancel
    @welcome_call = WelcomeCall.find(params[:id])
    if @welcome_call.update(available: true, booking_id: nil, name: nil)
      flash[:alert] = 'Our call has been canceled.'
      redirect_to root_path
    else
      flash[:alert] = "Oops, something wrent wrong. Please try it again."
      redirect_to booking_useredit_welcome_call(@booking.booking_auth_token, @booking, @old_welcome_call)
    end
  end

  private

  def welcome_calls_params
    params.require(:welcome_call).permit(
      :name,
      :start_time,
      :end_time,
      :available,
      :booking_id
    )
  end

  def date_of_next(day)
    date  = Date.parse(day)
    delta = date >= Date.today ? 0 : 7
    date + delta
  end

  def array_of_dates(booked_welcome_call_times)
    available_times = []
    ['Saturday', 'Tuesday', 'Wednesday'].each do |date|
      next if date_of_next(date) == Date.today

      available_times << Time.parse("#{date_of_next(date)} 10am")
      while available_times.last + 30.minutes < Time.parse("#{date_of_next(date)} 18:30pm")
        available_times << available_times.last + 30.minutes unless booked_welcome_call_times.include?(available_times.last + 30.minutes)
      end
    end
    return available_times
  end
end
