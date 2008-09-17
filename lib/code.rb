module Code
  def code(*args, &block)
    options = args.last.kind_of?(Hash) ? args.pop : Hash.new
    concat_erb("<div class=\"code\">", block.binding)
    concat_erb(%Q(<h5>#{h(args.first)}</h5>), block.binding) unless args.empty?
    coderay(options, &block)
    concat_erb("</div>", block.binding)
  end
end

Webby::Helpers.register(Code)
