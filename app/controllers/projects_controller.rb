class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  expose(:project, attributes: :project_params)
  expose(:projects) { current_user.projects }

  def index
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      format.html do
        project.save
        redirect_to projects_path, notice: "Project created!"
      end
      format.js { project.save }
    end
  end

  def update
    if project.save
      redirect_to projects_path, notice: "Project updated!"
    else
      render :edit, alert: "Something were wrong. Update unsuccessful"
    end
  end

  def destroy
    if project.destroy
      redirect_to projects_path, notice: "Project deleted!"
    else
      flash[:alert] = "Something were wrong. Delete unsuccessful"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_id, :parent_id)
  end
end
