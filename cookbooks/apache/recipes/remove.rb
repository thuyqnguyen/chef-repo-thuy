#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'install apache' do
  case node["platform"]
    when 'ubuntu', 'debian'
      package_name   'apache2'
    when 'amazon'
      package_name   'httpd'
    when 'centos', 'redhat'
      package_name   'http'
  end
  action :remove
end

#remove the directory created earlier from a remote_directory resource
directory '/tmp/remote_test_dir' do
  recursive true
  action :delete
end

