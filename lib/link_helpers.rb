module LinkHelpers
  def absolute_url(relative_url)
    page = @top_level_page || @page
    ("/" + relative_url).gsub(%r{/+}, "/")
  end

  def same_folder_url(relative_url)
    page = @top_level_page || @page
    absolute_url(page.directory + "/" + relative_url)
  end

  def comments_count(page)
    link_to("View Comments", page, :anchor => "disqus-thread")
  end

  def comments_form(page)
    <<-EOF
      <div id="disqus_thread"></div><script type="text/javascript" src="http://disqus.com/forums/asingleprogrammersblog/embed.js"></script><noscript><a href="http://asingleprogrammersblog.disqus.com/?url=ref">View the discussion thread.</a></noscript><a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>
    EOF
  end
end

Webby::Helpers.register(LinkHelpers)
