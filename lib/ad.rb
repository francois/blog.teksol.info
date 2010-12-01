module Ad
  def adgear_page_tags(page)
    if page.home then
      ["home"]
    elsif page.ad_tags.blank? then
      ["misc"]
    else
      page.ad_tags.map {|o| o.to_s}
    end
  end
end

Webby::Helpers.register(Ad)
