#monit.rb

service "monit" do
	action :stop
end

yum_package "monit" do
	version node[:monit][:version]
	action :install
	source '/tmp/monit-5.12.2-1.el6.x86_64.rpm'
end

template "/etc/monitrc" do
	source "monitrc.erb"
	mode 0700
	owner "root"
	group "root"
end

service "monit" do
	supports :status => true, :stop => true, :restart => true
	action [ :enable, :start ]
end


template "/etc/monit/conf.d/tomcat.conf" do
	variables({
		:recipient => node["monit"]["recipient"],
		:tomcatHome => node["splunk"]["user"]["home"]
	})
	source "monit_tomcat_conf.erb"
	owner "root"
	group "root"
	mode "0644"
	action :create
end

service "monit" do
	action :restart
end
