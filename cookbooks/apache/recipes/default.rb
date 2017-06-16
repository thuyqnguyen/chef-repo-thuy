#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache::test_variable'

Chef::Log.info ("platform from ohai is node[:platform]")

platform = node["platform"]
Chef::Log.info ("now, platform is #{platform}")

case node["platform"]
    when 'ubuntu', 'debian'
      apache_name = 'apache2'
    when 'amazon'
      apache_name = 'httpd'
    when 'centos', 'redhat'
      apache_name = 'http'
end

Chef::Log.info ("package name is #{apache_name}")

package apache_name do
  action :install
end
