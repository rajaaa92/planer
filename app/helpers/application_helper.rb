module ApplicationHelper
  def menu_class(name)
    'active' if name == controller_name
  end
end
