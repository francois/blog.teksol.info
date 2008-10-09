#!/usr/bin/env ruby
require "rubygems"
require "active_record"
require "net/scp"
require "fileutils"

ActiveRecord::Base.establish_connection(:adapter => "mysql", :database => "mephisto_teksol_development", :username => "root", :encoding => "utf8")
ActiveRecord::Base.logger = Logger.new(STDERR)

RAILS_ROOT = "/home/blog/blog.teksol.info/"

class Tag < ActiveRecord::Base
  def to_s; name; end
end
class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
end

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
class Article < Content
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
=begin
  `id` int(11) NOT NULL auto_increment,
  `article_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `permalink` varchar(255) default NULL,
  `excerpt` text,
  `body` text,
  `excerpt_html` text,
  `body_html` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `published_at` datetime default NULL,
  `type` varchar(20) default NULL,
  `author` varchar(100) default NULL,
  `author_url` varchar(255) default NULL,
  `author_email` varchar(255) default NULL,
  `author_ip` varchar(100) default NULL,
  `comments_count` int(11) default '0',
  `updater_id` int(11) default NULL,
  `version` int(11) default NULL,
  `site_id` int(11) default NULL,
  `approved` tinyint(1) default '0',
  `comment_age` int(11) default '0',
  `filter` varchar(255) default NULL,
  `user_agent` varchar(255) default NULL,
  `referrer` varchar(255) default NULL,
  `assets_count` int(11) default '0',
  `spam_engine_data` text,
=end
end

class Comment < Content; end

Article.find(:all, :conditions => "published_at IS NOT NULL", :order => "published_at").each do |article|
  puts article.permalink
  filename = "content/%04d/%02d/%02d/%s.txt" % [article.published_at.year, article.published_at.month, article.published_at.day, article.permalink]
  content = File.read(filename)
  content.sub!("blog_post:  true", "blog_post:  true\r\ntags:       #{article.tags.join(", ")}")
  File.open(filename, "wb") do |io|
    io.write content
  end
end
