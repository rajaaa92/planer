class IdeasController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  expose(:idea, attributes: :idea_params)
  expose(:ideas) { current_user.ideas }
  expose(:project)

  def index
  end

  def create
    respond_to do |format|
      format.js { idea.save }
    end
  end

  def update
    respond_to do |format|
      format.json do
        idea.save
        respond_with idea
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        idea.destroy
      end
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :user_id)
  end
end
