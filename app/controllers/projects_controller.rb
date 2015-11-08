class ProjectsController < ApplicationController
  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      #TODO
    end
  end

  def show
    @project = Project.find_by(id: params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:name, :descripton)
  end
end
