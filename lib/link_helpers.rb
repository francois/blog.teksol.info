module LinkHelpers
  def absolute_url(relative_url)
    root = "../" * @page.directory.split("/").length
    root + relative_url
  end

  def same_folder_url(relative_url)
    absolute_url(@page.directory + "/" + relative_url)
  end
end

Webby::Helpers.register(LinkHelpers)
