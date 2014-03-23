class ProblemsController < ApplicationController

  before_filter :authenticate_user!

  expose(:problem, attributes: :problem_params)
  expose(:problems) { current_user.problems }

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
    if problem.save
      redirect_to problems_path, notice: "problem updated!"
    else
      render :edit, alert: "Something were wrong. Update unsuccessful"
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
