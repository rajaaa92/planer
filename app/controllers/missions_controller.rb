class MissionsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  expose(:mission, attributes: :mission_params)
  expose(:missions) { current_user.missions }
  expose(:project)

  def index
  end

  def create
    respond_to do |format|
      format.js { mission.save }
    end
  end

  def update
    respond_to do |format|
      format.json do
        mission.save
        respond_with mission
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        mission.destroy
      end
    end
  end

  def sort
    params[:mission_panel].each_with_index do |id, index|
      Mission.find(id).update_attribute(:position, index+1)
    end
    render nothing: true
  end

  private

  def mission_params
    params.require(:mission).permit(:name, :user_id)
  end
end
