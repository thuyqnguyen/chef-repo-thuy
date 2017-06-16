#
# Cookbook Name:: my_users
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users"

users_manage 'family' do
  group_id 510
  action :create
  data_bag 'users'
end  

  
