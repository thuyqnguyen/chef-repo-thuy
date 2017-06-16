#newrelic
directory '/opt/tomcat7/newrelic' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  action :create
end

include_recipe "platform_newrelic"
include_recipe "platform_newrelic::java-agent"

directory '/opt/tomcat7/newrelic' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  action :create
end
