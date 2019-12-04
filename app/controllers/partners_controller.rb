class PartnersController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @partner = Partner.new
  end

  def create
    partner = Partner.new(partners_params)
    if partner.save
      redirect_to partner
    else
      render :new
    end
  end

  def show
    @partner = Partner.find(params[:id])
  end

  private

  def partners_params
    params.require(:partner).permit(
      :name,
      :company,
      :email,
      :phone_code,
      :phone,
      :message
    )
  end
end
