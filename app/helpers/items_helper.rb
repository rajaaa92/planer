module ItemsHelper
  def sort_url
    self.send("sort_#{category}_url")
  end

  def form_url item=nil
    if item.present?
      self.send("#{category}_url") + "/#{item.id}"
    else
      self.send("#{category}_url")
    end
  end

  def category
    c = request.path.split('/').second
    c.present? && Item::ALLOWES_CATEGORIES.include?(c) ? c : Item::DEFAULT_CATEGORY
  end
end
