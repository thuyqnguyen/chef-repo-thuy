#include_recipe 'platform_httpd'

package 'httpd' do
  action :install
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  owner 'apache'
  group 'apache'
  mode '0755'
  notifies :restart, 'service[httpd]', :delayed
end

service 'httpd' do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true
end
