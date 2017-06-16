#
# Cookbook Name:: tools_nexus
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#### Install/Configure splunk ####
include_recipe 'tools_nexus::splunk'
#### Install/Configure newrelic ####
include_recipe "tools_tep::newrelic"
####Check_mk Agent ####
include_recipe "tools_tep::check_mk"
