class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    @user.skip_password_validation = true
    # Must delete first element of array, to keep database clean, because its an empty string
    @user.gender = @user.gender.pop(1)
    @user.prefered_suite = @user.prefered_suite.pop(1)
    @user.first_name = @user.first_name.capitalize
    @user.last_name = @user.last_name.capitalize
    @user.role = 'Applicant'
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def index
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
      prefered_suite: []
    )
  end
end
