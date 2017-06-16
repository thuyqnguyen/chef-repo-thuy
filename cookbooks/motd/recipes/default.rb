#
# Cookbook Name:: motd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/tmp/motd.txt' do
  source 'motd.txt'  
  mode '0755'
  action :create
end

template '/home/ec2-user/motd.txt' do
  source 'motd.erb'
end
