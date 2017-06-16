#
# Cookbook Name:: my_db
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#
# Cookbook Name:: my_sudo
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

mysql_service 'default' do
  port node[:my_db][:port] 
  initial_root_password node[:my_db][:root_password]
  action [:create, :start]
end

connection_params = {
  :host => '127.0.0.1',
  :username => 'root',
  :password => node['my_db']['root_password']
}

# this is needed for database cookbook
mysql2_chef_gem 'default' do
  gem_version '0.3.17'
  action :install
end

mysql_database node[:my_db][:db_name] do
  connection connection_params
  action :create
end

mysql_database_user node[:my_db][:db_user] do
  connection connection_params
  database_name node[:my_db][:db_name]
  password node[:my_db][:db_password]
  privileges [:all]
  action [:create, :grant]
end


