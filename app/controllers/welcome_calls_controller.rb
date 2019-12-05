class WelcomeCallsController < ApplicationController
  skip_before_action :authenticate_user!

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
    @welcome_calls = WelcomeCall.all
    @date = params[:date].to_date if present?
    @month_param = params[:month] ? "#{params[:month]}-01".to_date : Date.today
    @date_range = (@month_param.beginning_of_month.beginning_of_week..@month_param.end_of_month.end_of_week).to_a
  end

  # def new
  #   @welcome_call = WelcomeCall.new
  # end

  # def create
  #   @welcome_call = WelcomeCall.new(welcome_calls_params)
  # end

  def edit
    @welcome_calls = WelcomeCall.all.where("start_time > ?", Date.today)
  end

  def update

  end

  private

  def welcome_calls_params
    params.require(:welcome_call).permit(
      :name,
      :start_time,
      :end_time
    )
  end
end
