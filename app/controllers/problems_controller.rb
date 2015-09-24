class ProblemsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  expose(:problem, attributes: :problem_params)
  expose(:problems) { current_user.problems }
  expose(:project)

  def index
  end

  def create
    respond_to do |format|
      format.js { problem.save }
    end
  end

  def update
    respond_to do |format|
      format.json do
        problem.save
        respond_with problem
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        problem.destroy
      end
    end
  end

  def sort
    params[:problem_panel].each_with_index do |id, index|
      Problem.find(id).update_attribute(:position, index+1)
    end
    render nothing: true
  end

  private

  def problem_params
    params.require(:problem).permit(:name, :user_id)
  end
end
