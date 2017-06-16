#omd.rb
omd_version = node['dash']['omd_version']

yum_package 'xinetd' do
  action :install
end

service 'xinetd' do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true
end

yum_package 'nc' do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/check_mk-agent.rpm" do
  source "#{node['dash']['omd_url']}/check_mk-agent-#{omd_version}.rpm"
  owner 'root'
  group 'root'
  mode '0755'
end

rpm_package 'check_mk-agent.rpm' do
  action :install
  notifies :restart, 'service[xinetd]', :immediately
end

#bash 'OMD deployment' do
#  code <<-EOH
#  rpm -Uvh check_mk-agent.rpm
#  EOH
#  notifies :restart, 'service[xinetd]', :immediately 
#end
