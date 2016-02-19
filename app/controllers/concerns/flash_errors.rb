module FlashErrors
  extend ActiveSupport::Concern

  private

  def add_flash_errors resource
    flash[:error] = (flash[:error].to_a.concat resource.errors.full_messages).uniq
  end
end
