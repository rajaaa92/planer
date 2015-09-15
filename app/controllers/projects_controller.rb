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

  private

  def project_params
    params.require(:project).permit(:name, :user_id, :parent_id)
  end
end
