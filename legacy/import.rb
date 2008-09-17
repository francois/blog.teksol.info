#!/usr/bin/env ruby
require "rubygems"
require "active_record"
require "net/scp"
require "uri/open-scp"

ActiveRecord::Base.establish_connection(:adapter => "mysql", :database => "mephisto_teksol_development", :username => "root", :encoding => "utf8")
ActiveRecord::Base.logger = Logger.new(STDERR)

RAILS_ROOT = "/home/blog/blog.teksol.info/"

class Asset < ActiveRecord::Base
  def permalink
    date = created_at || Time.now.utc
    pieces = [date.year, date.month, date.day]
    pieces * '/'
  end

  def thumbnail_name_for(thumbnail = nil)
    return filename if thumbnail.blank?
    ext = nil
    basename = filename.gsub /\.\w+$/ do |s|
      ext = s; ''
    end
    "#{basename}_#{thumbnail}#{ext}"
  end

  def full_filename(thumbnail = nil) 
    File.join(RAILS_ROOT, 'public/assets', permalink, thumbnail_name_for(thumbnail)) 
  end
end

class Content < ActiveRecord::Base; end
class Article < Content; end
class Comment < Content; end

puts "Found #{Asset.count} assets, #{Article.count} articles and #{Comment.count} comments"
Asset.all.each do |asset|
  local_filename = "content/assets/#{File.basename(asset.full_filename)}"
  next if File.file?(local_filename)
  puts asset.full_filename
  File.open(local_filename, "wb") do |io|
    io.write(open("scp://blog@teksol.info#{asset.full_filename}").read)
  end
end
