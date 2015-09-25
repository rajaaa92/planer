module ApplicationHelper
  def menu_class(name)
    return 'current' if request.path.present? && request.path.include?(name)
    return 'current' if name == params[:controller]
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'error'
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def javascript_exists?(script)
    extensions = %w(.coffee .erb .coffee.erb) + [""]
    extensions.inject(false) do |truth, extension|
      truth || asset_exists?('javascripts', "#{script}.js#{extension}")
    end
  end

  def asset_exists?(subdirectory, filename)
    File.exists?(File.join(Rails.root, 'app', 'assets', subdirectory, filename))
  end
end
