class RoomsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @rooms = Room.all.where(project_id: params[:project_id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(rooms_params)
    if @room.save
      redirect_to @room
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(rooms_params)
      flash[:alert] = "Room successfully updated."
      redirect_to @room
    else
      flash[:alert] = "Oops something went wrong. Please try again."
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.delete
      flash[:alert] = "Room successfully deleted."
    else
      flash[:alert] = "Oops something went wrong. Please try again."
    end
    redirect_to rooms_path
  end

  private

  def rooms_params
    params.require(:rooms).permit(
      :project_id,
      :number,
      :name,
      :size,
      :description,
      price: [],
      pictures: []
    )
  end
end
