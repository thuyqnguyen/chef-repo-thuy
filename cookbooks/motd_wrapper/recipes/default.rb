#
# Cookbook Name:: motd_wrapper
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "motd"

begin
  t = resources(:template => "/home/ec2-user/motd.txt")
  t.cookbook 'motd_wrapper'
  t.variables(
    "from_the_master" => node['motd_wrapper']['msg'] 
  )
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warning "could not find template /home/ec2-user/motd.txt to modify"
end
