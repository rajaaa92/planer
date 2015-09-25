module ItemsHelper
  def sort_url
    self.send("sort_#{category.pluralize}_url")
  end

  def form_url item=nil
    if item.present?
      self.send("#{category.pluralize}_url") + "/#{item.id}"
    else
      self.send("#{category.pluralize}_url")
    end
  end

  def category
    c = request.path.split('/').second.try(:singularize)
    c.present? && Item::ALLOWED_CATEGORIES.include?(c) ? c : Item::DEFAULT_CATEGORY
  end
end
