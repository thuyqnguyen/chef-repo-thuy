#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

case node['platform']
    when 'ubuntu', 'debian'
      apache_name = 'apache2'
    when 'amazon'
      apache_name = 'httpd'
    when 'centos', 'redhat'
      apache_name = 'http'
end

log ("this is log.... #{node['platform]} ")
log ("this is log.... #{apache_name} ")
