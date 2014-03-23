class IdeasController < ApplicationController

  before_filter :authenticate_user!

  expose(:idea, attributes: :idea_params)
  expose(:ideas) { current_user.ideas }
  expose(:project)

  def index
  end

  def new
  end

  def edit
  end

  def create
    if idea.save
      redirect_to ideas_path, notice: "Idea created!"
    else
      render :new, alert: "Something were wrong. Create unsuccessful"
    end
  end

  def update
    if idea.save
      redirect_to ideas_path, notice: "Idea updated!"
    else
      render :edit, alert: "Something were wrong. Update unsuccessful"
    end
  end

  def destroy
    if idea.destroy
      redirect_to ideas_path, notice: "Idea deleted!"
    else
      flash[:alert] = "Something were wrong. Delete unsuccessful"
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :user_id)
  end
end
