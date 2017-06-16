# encoding: utf-8
#include_recipe 'tarball::default'
#node['dash']['ui_path'] = '/opt/tomcat7/webapps/config'
deploy_version = node['dash']['deploy_version']
app_version = node['dash']['app_deploy_version']
job_version = node['dash']['job_deploy_version']
config_version = node['dash']['ui_deploy_version']
install_path = node['dash']['install_path']
#ui_path = node['dash']['ui_path']

directory '/opt/tomcat7/webapps/config' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  action :create
end

directory "/opt/tomcat7/webapps/dashboard" do
  recursive true
  action :delete
end

directory "/opt/tomcat7/webapps/dashboard-job" do
  recursive true
  action :delete
end

bash 'save current war files and configs' do
  cwd install_path
  code <<-EOH
  /bin/mv dashboard.war dashboard.war.bak;
  /bin/mv dashboard-job.war dashboard-job.war.bak;
  /bin/cp -r config config.bak;
  EOH
end

remote_file "#{Chef::Config[:file_cache_path]}/#{deploy_version}" do
  source "#{node['dash']['url']}/#{deploy_version}"
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
end

bash 'unzip all wars' do
  cwd ::File.dirname(install_path)
  code <<-EOH
  /bin/tar -xf #{Chef::Config[:file_cache_path]}/#{deploy_version} -C #{node['dash']['install_path']}
  EOH
end

file '/opt/tomcat7/webapps/dashboard.war' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/opt/tomcat7/webapps/dashboard-job.war' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

bash 'new ui deployment' do
  cwd ::File.dirname(install_path)
  code <<-EOH
  /bin/rm -rf config/*
  /bin/tar -xf #{node['dash']['install_path']}/config.tgz -C #{node['dash']['install_path']}/config/
  /bin/rm -rf config.tgz
  EOH
end

# remote_file "#{Chef::Config[:file_cache_path]}/dashboard.war" do
#   source "#{node['dash']['url']}/dashboard-service/0.0.1-SNAPSHOT/dashboard-service-#{app_version}.war"
#   owner 'tomcat'
#   group 'tomcat'
#   mode '0755'
# #  not_if { ::File.exists?(version_file) }
# end

# remote_file "#{Chef::Config[:file_cache_path]}/dashboard-job.war" do
#   source "#{node['dash']['url']}/dashboard-job-service/0.0.1-SNAPSHOT/dashboard-job-service-#{job_version}.war"
#   owner 'tomcat'
#   group 'tomcat'
#   mode '0755'
# #  not_if { ::File.exists?(version_file) }
# end

# remote_file "#{Chef::Config[:file_cache_path]}/#{config_version}" do
#   source "#{node['dash']['ui_url']}/dashboard-config-ui/#{config_version}"
#   owner 'tomcat'
#   group 'tomcat'
#   mode '0755'
# #  not_if { ::File.exists?(version_file) }
# end

# bash 'app deployment' do
#   cwd ::File.dirname(install_path)
#   code <<-EOH
#   #/bin/rm -rf #{node['dash']['install_path']}/dashboard/
#   #/bin/rm -rf #{node['dash']['install_path']}/dashboard.war
#   mv #{Chef::Config[:file_cache_path]}/dashboard.war #{node['dash']['install_path']}
#   EOH
# end

# bash 'job deployment' do
#   cwd ::File.dirname(install_path)
#   code <<-EOH
#   #/bin/rm -rf #{node['dash']['install_path']}/dashboard-job/
#   #/bin/rm -rf #{node['dash']['install_path']}/dashboard-job.war
#   mv #{Chef::Config[:file_cache_path]}/dashboard-job.war #{node['dash']['install_path']}
#   EOH
# end

# bash 'ui deployment' do
#   cwd ::File.dirname(install_path)
#   code <<-EOH
#   /bin/rm -rf config/*
#   /bin/tar -xf #{Chef::Config[:file_cache_path]}/#{config_version} -C #{node['dash']['install_path']}/config/
#   EOH
# end

directory '/opt/tomcat7/webapps/config' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  recursive true
  action :create
end
