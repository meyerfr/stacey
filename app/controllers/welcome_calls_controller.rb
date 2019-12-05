class WelcomeCallsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @welcome_calls = WelcomeCall.all
  end

  def new
    @welcome_call = WelcomeCall.new
  end

  def create
    @welcome_call = WelcomeCall.new(welcome_calls_params)
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
