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
    request.path.split('/').second
  end
end
