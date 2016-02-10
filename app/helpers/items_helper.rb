module ItemsHelper
  def sort_url
    self.send("sort_#{category.pluralize}_url")
  end

  def form_url item=nil
    url = self.send("#{category.pluralize}_url")
    item.present? ? url + "/#{item.id}" : url
  end

  def category
    c = request.path.split('/').second
    c = c.split('.').first.try(:singularize) if c.present?
    c.present? && Item::ALLOWED_CATEGORIES.include?(c) ? c : Item::DEFAULT_CATEGORY
  end
end
