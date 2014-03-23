class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  expose(:project, attributes: :rate_params)
  expose(:projects)

  def index
  end

  def new
  end

  def edit
  end

  def create
    if project.save
      redirect_to projects_path, notice: "Project created!"
    else
      render :new, alert: "Something were wrong. Create unsuccessful"
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

  def rate_params
    params.require(:project).permit(:name, :user_id, :parent_id)
  end
end
