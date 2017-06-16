#
# Cookbook Name:: my_sudo
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default['authorization']['sudo']['passwordless'] = true
node.default['authorization']['sudo']['groups'] = ['family']
include_recipe 'sudo'


