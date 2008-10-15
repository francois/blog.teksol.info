module LinkHelpers
  def absolute_url(relative_url)
    page = @top_level_page || @page
    ("/" + relative_url).gsub(%r{/+}, "/")
  end

  def same_folder_url(relative_url)
    page = @top_level_page || @page
    absolute_url(page.directory + "/" + relative_url)
  end
end

Webby::Helpers.register(LinkHelpers)
