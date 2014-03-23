class MissionsController < ApplicationController

  before_filter :authenticate_user!

  expose(:mission, attributes: :mission_params)
  expose(:missions) { current_user.missions }

  def index
  end

  def new
  end

  def edit
  end

  def create
    if mission.save
      redirect_to missions_path, notice: "Mission created!"
    else
      render :new, alert: "Something were wrong. Create unsuccessful"
    end
  end

  def update
    if mission.save
      redirect_to missions_path, notice: "Mission updated!"
    else
      render :edit, alert: "Something were wrong. Update unsuccessful"
    end
  end

  def destroy
    if mission.destroy
      redirect_to missions_path, notice: "Mission deleted!"
    else
      flash[:alert] = "Something were wrong. Delete unsuccessful"
    end
  end

  private

  def mission_params
    params.require(:mission).permit(:name, :user_id)
  end
end
