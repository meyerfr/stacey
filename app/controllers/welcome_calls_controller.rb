class WelcomeCallsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_booking_auth_token!, only: [:book]

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

    if period_param
      if search_param && period_param == 'upcoming'
        @welcome_calls = WelcomeCall.all.where("start_time >= ? AND available = ? AND lower(name) = ?", Time.now, false, search_param.downcase) if search_param
      elsif search_param && period_param == 'past'
        @welcome_calls = WelcomeCall.all.where("start_time < ? AND available = ? AND lower(name) = ?", Time.now, false, search_param.downcase) if search_param
      elsif period_param == 'past'
        @welcome_calls = WelcomeCall.all.where("start_time < ? AND available = ?", Time.now, false)
      end
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

    month_helper = "#{params[:month]}-#{@date.strftime('%d')}".to_date if params[:month]
    @month_param = params[:month] && Date.today <= month_helper && month_helper <= Date.today + 9.days ? month_helper : Date.today
    # @month_param = params[:month] ? "#{params[:month]}-01".to_date : Date.today
    @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  def update
    @user = User.find(params[:user_id])
    @welcome_call = WelcomeCall.find(params[:id])
    @welcome_call.available = false
    @welcome_call.user = @user
    @welcome_call.name = "#{@user.first_name} #{@user.last_name}"
    if @welcome_call.save
      # Send email with all the information
      flash[:alert] = "We just send you an email with all informations."
      redirect_to :root
    else
      flash[:alert] = "Oops, something wrent wrong. Please try it again."
      redirect_to edit_user_welcome_call(@user)
    end
  end

  private

  def welcome_calls_params
    params.require(:welcome_call).permit(
      :name,
      :start_time,
      :end_time,
      :available,
      :user_id
    )
  end
end
