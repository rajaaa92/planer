class ApplicationController < ActionController::Base
  protect_from_forgery

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  before_filter :set_locale

  private

  def set_locale
    params[:locale].present? ? I18n.locale = params[:locale] : I18n.locale = "en"
  end
end
