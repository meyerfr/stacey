class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
    @user.bookings.new
  end

  def create
    @user = User.new(users_params)
    @user.skip_password_validation = true
    # Must delete first element of array, to keep database clean, because its an empty string
    @user.gender = @user.gender.pop(1) if @user.gender.length.positive?
    @user.prefered_suite = @user.prefered_suite.pop(1) if @user.prefered_suite.length.positive?
    @user.first_name = @user.first_name.capitalize
    @user.last_name = @user.last_name.capitalize
    @user.email = @user.email.downcase
    @user.role = 'Applicant'
    if @user.save
      # create booking. Validation and correct duration has been checked
      move_in_helper_array = users_params[:bookings_attributes]['0'].values.first(3).map! { |e| e.to_i }.reverse
      move_in_date = Date.new(move_in_helper_array[0], move_in_helper_array[1], move_in_helper_array[2])
      move_out_helper_array = users_params[:bookings_attributes]['0'].values.last(3).map! { |e| e.to_i }.reverse
      move_out_date = Date.new(move_out_helper_array[0], move_out_helper_array[1], move_out_helper_array[2])
      @booking = @user.bookings.new(move_in: move_in_date, move_out: move_out_date)
      @booking.booking_auth_token = Devise.friendly_token
      @booking.booking_auth_token_exp = Date.today + 1.week
      @booking.save
      # redirection to calendar page. Schedule welcome call
      redirect_to booking_book_welcome_call_path(@booking.booking_auth_token, @booking, date: Date.today)
    else
      @user.bookings.new
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def users_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone_code,
      :phone_number,
      :dob,
      :job,
      :move_in,
      :move_out,
      :street,
      :city,
      :zipcode,
      :country,
      :amount_of_people,
      :linkedin,
      :facebook,
      :twitter,
      :instagram,
      :photo,
      gender: [],
      prefered_suite: [],
      bookings_attributes: Booking.attribute_names.map(&:to_sym).push(:_destroy)
    )
  end
end

# def send_invitation_for_contract_pages
#   @user = User.find(params[:user])
#   @flat = Flat.first
#   @authentity_token_contract = Devise.friendly_token
#   @expiration_date = Date.today + 1.week
#   @user.update!(authentity_token_contract: @authentity_token_contract, authentity_token_contract_expiration: @expiration_date)
#   UserMailer.contract_mail(@user, @flat, @authentity_token_contract).deliver_now
#   redirect_to applicants_index_path
# end
