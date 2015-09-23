class ProblemsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  expose(:problem, attributes: :problem_params)
  expose(:problems) { current_user.problems }
  expose(:project)

  def index
  end

  def new
  end

  def edit
  end

  def create
    if problem.save
      redirect_to problems_path, notice: "Problem created!"
    else
      render :new, alert: "Something were wrong. Create unsuccessful"
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
    if problem.destroy
      redirect_to problems_path, notice: "problem deleted!"
    else
      flash[:alert] = "Something were wrong. Delete unsuccessful"
    end
  end

  private

  def problem_params
    params.require(:problem).permit(:name, :user_id)
  end
end
