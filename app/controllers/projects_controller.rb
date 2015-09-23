class ProjectsController < ApplicationController
  respond_to :html, :json

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
      format.js { project.save }
      format.html do
        if project.save
          redirect_to projects_path, notice: "Project created!"
        else
          redirect_to projects_path, alert: "Something were wrong. Create unsuccessful"
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        project.save
        respond_with project
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js { project.destroy }
    end
  end

  def sort
    params[:project_panel].each_with_index do |id, index|
      Project.find(id).update_attribute(:position, index+1)
    end
    render nothing: true
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_id, :parent_id)
  end
end
