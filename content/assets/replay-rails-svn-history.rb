#!/usr/bin/ruby
require 'rexml/xpath'
require 'rexml/document'
require 'tempfile'

def run(cmd)
  $stderr.puts "> #{cmd}"
  results = `#{cmd}`
  results
end

def patch_name(revision)
  "imported Rails r#{revision}"
end

info = run("svn info vendor/rails")
info =~ /^Revision: (\d+)$/
CurrentRevision = $1.to_i
info =~ /^URL:\s+(.*)$/i
RailsRepository = $1

logs = REXML::Document.new(run("svn log --xml --revision #{CurrentRevision + 1}:HEAD #{RailsRepository}"))
messages = {}
REXML::XPath.each(logs, '//logentry') do |entry|
  revision = REXML::XPath.first(entry, 'attribute::revision').value.to_i
  author = REXML::XPath.first(entry, 'child::author/text()').to_s
  message = REXML::XPath.first(entry, 'child::msg/text()').to_s

  messages[revision] = { :revision => revision, :author => author, :message => message }
end

messages.sort.map {|e| e.last}.each do |entry|
  addlist = []
  updatelist = []
  removelist = []
  results = run("svn update --revision #{entry[:revision]} vendor/rails")
  results.each {|line| next unless line[0,1] == 'A'; addlist << line[5..-1].chomp}
  results.each {|line| next unless line[0,1] == 'D'; removelist << line[5..-1].chomp}
  results.each {|line| next unless line[0,1] == 'U'; updatelist << line[5..-1].chomp}

  puts "Removing #{removelist.size}, Adding #{addlist.size}, Updating #{updatelist.size}"

  until(removelist.empty?) do
    paths = removelist.slice!(0, 10)
    run("darcs remove #{paths.join(' ')}")
  end

  until(addlist.empty?) do
    paths = addlist.slice!(0, 10)
    run("darcs add #{paths.join(' ')}")
  end

  run("darcs record --author #{entry[:author]} --all --patch-name=\"#{patch_name(entry[:revision])}\"")

  puts
end
