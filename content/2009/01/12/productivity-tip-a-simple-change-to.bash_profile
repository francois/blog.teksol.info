--- 
title:      "Productivity Tip: A Simple Change to ~/.bash_profile"
created_at: 2009-01-12 10:16:12
id:         20090112101612
tags: 
  - tips
blog_post:  true
filter:
  - erb
  - textile
--- 
I put everything I code into <code class="dir">~/Documents/work</code>.  Could be called projects, same thing.  Anyway, everytime I opened Terminal, I would have to type <code class="dir">cd Documents/work</code>.  Of course, with tab completion, it's not so bad.  I'm a bit stupid though, and it takes me eons before I added <code class="dir">cd ~/Documents/work</code> to the end of my <code class="path">~/.bash_profile</code>.

Whenever I open a Terminal, I'm really going to start doing something in this folder.  Now, why didn't I think of that earlier?  Next: retrain myself to not cd anywhere when I open a new Terminal&hellip;

Here's my full <code class="path">~/.bash_profile:</code>

<% code("~/.bash_profile", :lang => :bash) do %>#!/usr/bin/sh

# Installed by Git OSX Installer from
# http://code.google.com/p/git-osx-installer/
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
export ANT_HOME=/usr/share/ant
export JRUBY_HOME=~/Library/Java/JRuby/current
export MYSQL_PATH=/usr/local/mysql
export PATH=~/bin:/opt/local/sphinx/bin:/usr/local/git/bin:$MYSQL_PATH/bin:$PATH:$JRUBY_HOME/bin
export MANPATH=/usr/local/git/man:$MANPATH
export EDITOR=vim

# And this is from:
# http://code.google.com/p/git-osx-installer/
export PS1='\w$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo " (\[\033[00m\]$(git branch | grep ^*|sed s/\*\ //))"; fi) \$\[\033[00m\] '

export VISUALWORKS=~/Applications/vw7.6nc
export AWS_ACCESS_KEY_ID= # your AWS access key, for cliaws gem
export AWS_SECRET_ACCESS_KEY= # your AWS secret access key, for cliaws gem again

# http://www.macosxhints.com/article.php?story=20060502160527780&query=terminal%2Btitle
function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

cd ~/Documents/work
<% end %>
