#!/usr/bin/env ruby
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'ruby-growl'

@retry = 0
@g = Growl.new("127.0.0.1", "ruby-growl", ["ruby-growl Notification"])
@last_item = ''
while(true)
  begin
    doc = open("http://www.woot.com/") { |f| Hpricot(f) }
  rescue Exception => e
    puts "ruby-growl Notification", "Network Down", "#{e}"
    @g.notify "ruby-growl Notification", "Network Down", "#{e}"
    sleep 30
    @retry += 1
    retry if @retry < 3
  end
  item = doc.search("//h3").innerHTML   # assume H3 will contain woot item info
  puts item
  if @last_item != item
    @g.notify "ruby-growl Notification", "New Woot Item - #{item}", "New Woot Item - #{item}"
    sleep 1
    @g.notify "ruby-growl Notification", "New Woot Item - #{item}", "New Woot Item - #{item}"
    sleep 1
    @g.notify "ruby-growl Notification", "New Woot Item - #{item}", "New Woot Item - #{item}"
  end
  @last_item = item
  sleep 60 * 5
end
