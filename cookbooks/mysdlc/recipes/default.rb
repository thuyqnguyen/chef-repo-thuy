#
# Cookbook Name:: mysdlc
# Recipe:: default
#
# Copyright (C) 2017 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

puts "i'm #{node['name']}"
puts "iam #{node.name}"

include_recipe "mysdlc::tomcat"
