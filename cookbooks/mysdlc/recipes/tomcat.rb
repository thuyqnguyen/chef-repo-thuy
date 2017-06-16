
#package 'tomcat7' do
#  action :install
#end

template '/etc/sysconfig/tomcat7' do
  source 'tomcat7.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :db_host => node[:dash][:db_host],
    :app_env => node[:dash][:app_env],
    :db_key => node[:dash][:db_key],
    :default_job => node[:dash][:default_job],
    :resetDomoSchema => node[:dash][:resetDomoSchema],
    :jss_enable => node[:dash][:jss_enable],
    :db_user => node[:dash][:db_user],
    :db_pwd => node[:dash][:db_pwd],
    :proxy => node[:dash][:proxy],
    :cachedPeer => node[:dash][:cachedPeer]
  )
  notifies :restart, 'service[tomcat7]', :delayed
end

service 'tomcat7' do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true
  only_if {node[:dash][:active_tomcat] == 'true'}
end
