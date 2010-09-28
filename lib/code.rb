gem "activesupport", "~> 2.3.5"
require "active_support"
require "coderay"

module Code
  DEFAULT_CODERAY_OPTIONS = {:lang => "ruby", :line_numbers => :inline, :bold_every => 5, :tab_width => 2}

  def code(*args, &block)
    text = capture_erb(&block)
    return if text.empty?
    text.gsub!("<#%", "<%")
    text.gsub!(" ---\n", "---\n")

    options = args.extract_options!
    options.reverse_merge!(DEFAULT_CODERAY_OPTIONS)
    language = (options.delete(:lang) || args.shift).to_s
    the_code = [].tap do |buffer|
      buffer << %Q(<div class="code">)
      buffer << %Q(<h5>#{h(args.first)}</h5>) unless args.empty?
      buffer << %Q(<div class="CodeRay"><pre>)
      buffer << ::CodeRay.scan(text, language).html(options)
      buffer << %Q(</pre></div>)
      buffer << %Q(</div>)
    end.join("\n")

    concat_erb(_guard(the_code), block.binding)
  end
end

Webby::Helpers.register(Code)
