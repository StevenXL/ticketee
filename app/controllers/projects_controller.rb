class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index
    @projects = Project.all
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been updated."
      render 'edit'
    end
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])

    if @project.nil?
      flash[:alert] = "The project you were looking for cannot be found."
      redirect_to projects_path
    end
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
