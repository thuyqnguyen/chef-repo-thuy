#
# Cookbook Name:: myfileresource
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

myresource_file '/home/ec2-user/fileResouce.txt' do
  content "Contenment is a very Happy Resource"
#  path    '/home/ec2-user/fileResouce.txt'
end

myresource_site 'httpd' do
  homepage '<h1>Welcome to the Example Co. website!</h1>'
  action :create
end
