
########################################################
# => 
# => CHECK_MK_AGENT Instllation on TEP  Servers                #
# => 
########################################################

check_mk_mirror = node["check_mk_install"]["mirror"]
check_mk_download_dir = node["check_mk_download"]["dir"]

omd_bag = data_bag_item("tools_tep", "check_mk")
rpm_version = omd_bag["version"]

#rpm_version = "1.2.4p5-1"

check_mk_agent_rpm = "check_mk-agent-#{rpm_version}.noarch.rpm"

remote_file "#{check_mk_download_dir}/#{check_mk_agent_rpm}" do
  source "#{check_mk_mirror}/#{check_mk_agent_rpm}"
  not_if "rpm -qa | grep -q '^check-mk-agent-#{rpm_version}'"
  notifies :install, "rpm_package[check_mk_agent]", :immediately
end


rpm_package "check_mk_agent" do
  source "#{check_mk_download_dir}/#{check_mk_agent_rpm}"
  only_if {::File.exists?("#{check_mk_download_dir}/#{check_mk_agent_rpm}")}
  action :nothing
  notifies :reload, 'service[xinetd]', :immediately
end

service "xinetd" do
  action [:enable, :start]
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
end

%w[ /etc/check_mk /usr/lib/check_mk_agent /usr/lib/check_mk_agent/local /usr/lib/check_mk_agent/plugins ].each do |path|
  directory path do
    owner 'root'
    group 'root'
    mode '0755'
  end
end

cookbook_file "/usr/bin/check_mk_agent" do
  mode "0755"
  owner "root"
  group "root"
  source "check_mk_agent"
end

template "/etc/xinetd.d/check_mk" do
    source "check_mk.erb"
    mode "0755"
    owner "root"
    group "root"
    variables(
    :omd_server => node[:omd][:omd_server]
  )
end


