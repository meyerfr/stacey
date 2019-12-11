class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    # @attachment = @item.attachments.create!(:media_files => a, item_id: @item.id, account_id: nil)
    @project = Project.new(projects_params)
    @project.name = @project.name.titleize
    @project.street = @project.street.titleize
    @project.city = @project.city.titleize
    if @project.save
      # if @project.pictures.length.positive?
      #   @project.pictures.each do |picture|
      #     File.delete(picture.filename)
      #   end
      # end
      redirect_to projects_path
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @projct.update(projects_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.delete
      redirect_to projects_path
    else
      redirect_to :back
    end
  end

  private

  def projects_params
    params.require(:project).permit(
      :street,
      :house_number,
      :city,
      :zipcode,
      :name,
      :description,
      pictures: []
    )
  end
end
