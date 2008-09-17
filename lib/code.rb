require "active_support"
require "coderay"

module Code
  DEFAULT_CODERAY_OPTIONS = {:lang => "ruby", :line_numbers => :inline, :bold_every => 5, :tab_width => 2}

  def code(*args, &block)
    text = capture_erb(&block)
    return if text.empty?
    text.gsub!("<#%", "<%")
    text.gsub!(" ---\n", "---\n")

    options = args.last.kind_of?(Hash) ? args.pop : Hash.new
    the_code = returning([]) do |buffer|
      buffer << %Q(<div class="code">)
      buffer << %Q(<h5>#{h(args.first)}</h5>) unless args.empty?
      buffer << %Q(<div class="CodeRay"><pre>)
      buffer << ::CodeRay.scan(text, options.delete(:lang)).html(options.reverse_merge(DEFAULT_CODERAY_OPTIONS))
      buffer << %Q(</pre></div>)
      buffer << %Q(</div>)
    end.join("\n")

    concat_erb(_guard(the_code), block.binding)
  end
end

Webby::Helpers.register(Code)
