#### HA ####
# where is prd live
default['dash']['prd_dc_live'] = 'qy'
#default['dash']['prd_dc_live'] ='lv'
# where is prf live
default['dash']['prf_dc_live'] ='qy'
#default['dash']['prf_dc_live'] ='lv'

# hostnames in each dc
default['dash']['prd_qydc_hostnames'] = ['pprdsdlas300.corp.intuit.net', 'pprdsdlas301.corp.intuit.net']
default['dash']['prd_lvdc_hostnames'] = ['pprdsdlas400.corp.intuit.net', 'pprdsdlas401.corp.intuit.net']
default['dash']['prf_qydc_hostnames'] = ['pprfsdlas300.corp.intuit.net', 'pprfsdlas301.corp.intuit.net']
default['dash']['prf_lvdc_hostnames'] = ['pprfsdlas400.corp.intuit.net']

# live hostnames
default['dash']['live_hostnames'] = []

if node['dash']['prd_dc_live'] == 'qy'
  default['dash']['live_hostnames'] = default['dash']['live_hostnames'] + node['dash']['prd_qydc_hostnames']
elsif node['dash']['prd_dc_live'] == 'lv'
  default['dash']['live_hostnames'] = default['dash']['live_hostnames'] + node['dash']['prd_lvdc_hostnames']
end
if node['dash']['prf_dc_live'] == 'qy'
  default['dash']['live_hostnames'] = default['dash']['live_hostnames'] + node['dash']['prf_qydc_hostnames']
elsif node['dash']['prf_dc_live'] == 'lv'
  default['dash']['live_hostnames'] = default['dash']['live_hostnames'] + node['dash']['prf_lvdc_hostnames']
end

#### DEPLOYMENT ####
default['dash']['install_path'] = "/opt/tomcat7/webapps"

#### YUM  ######
default['kernel_version'] = `/bin/uname -r`
case node['kernel_version'][0,1]
	when '3'
	#os version 7
		node.override['platform_yum']['repos']['list'] = [ 'oem', 'spc-base', 'spc-updates' ]
	when '2'
		node.override['platform_yum']['repos']['list'] = [ 'oem', 'ctorepo', 'spc-base', 'spc-os-specific-base', 'spc-os-specific-updates', 'spc-updates' ]
end

####  JAVA  #######
node.override['java']['jdk_version'] = '8'
node.override['platform_java']['jdk_full_version'] = "1.8.0_51-fcs"
node.override['platform_java']['install_jce'] = "true"
####  MONIT ########
default["monit"]["interval"] = "60"
# Set monit recipient
default["monit"]["recipient"] = "CTO-DevTeamDomo@intuit.com"
default["splunk"]["user"]["home"] = "/opt/tomcat7"

####  TOMCAT  #######
default['dczone'] = node.environment.split("_").last
node.override['dash']['url'] = "http://pprdnexusas301.corp.intuit.net/nexus/content/repositories/ENG.CTG.Intuit-Snapshots/com/intuit/platform/dashboard/release-candidates"
node.override['dash']['deploy_version']= "dashboard-v1.0.19-fbb85c4955845ff2bc47953c32b4d7720499839a.tgz"
case node['dczone'][0,3]
  when 'prd'
	node.override['dash']['app_env'] = 'prd'
	node.override['dash']['db_key'] = 'dashboard-prd-3f79378941404ad8babc7b8691b2406b'
  when 'prf'
	node.override['dash']['app_env'] = 'prf'
	node.override['dash']['db_key'] = 'dashboard-preprod-d956ef5c923711e58994feff819cdc9f'
  when 'qal'
	node.override['dash']['app_env'] = 'qal'
	node.override['dash']['db_key'] = 'dashboard-preprod-d956ef5c923711e58994feff819cdc9f'
  when 'dev'
	node.override['dash']['app_env'] = 'dev'
	node.override['dash']['db_key'] = 'dashboard-preprod-d956ef5c923711e58994feff819cdc9f'
end

node.override['dash']['resetDomoSchema'] = 'false'
node.override['dash']['jss_enable'] = 'false'
node.override['dash']['omd_version'] = ''
node.override['dash']['omd_url'] = ''
node.override['dash']['default_job'] = 'false'
app_env=node['dash']['app_env']
#db_credential = Chef::EncryptedDataBagItem.load("tools_sdlc", "db_pwd_#{app_env}")
#node.override['dash']['db_user'] = db_credential["db_user"]
#node.override['dash']['db_pwd'] = db_credential["db_pwd"]
node.override['dash']['active_tomcat'] = 'false'
#proxy
case node['dczone'][3,2]
  when 'qy'
	node.override['dash']['proxy'] = 'qy1prdproxy01.ie.intuit.net'
  when 'lv'
   	node.override['dash']['proxy'] = 'lvdcproxy01.pprod.ie.intuit.net'
end
#
case node['dczone'][0,3]
  when 'qal'
  	node.override['dash']['db_host'] = node.name
  	  	node.override['dash']['active_tomcat'] = 'true'
  when 'dev'
  	node.override['dash']['db_host'] = node.name
  	  	node.override['dash']['active_tomcat'] = 'true'
  when 'prf'
  	node.override['dash']['db_host'] = node.name.sub! 'las', 'ldb'
  when 'prd'
  	node.override['dash']['db_host'] = node.name.sub! 'las', 'ldb'
end


#puts "node=#{node}"

#prf/prd live DC
default['hostname'] = node.name.split(".")[0]

#active tomcat
if node['dash']['live_hostnames'].include? hostname
  node.override['dash']['active_tomcat'] = 'true'
end

#default job is the first hostname in each dc hostnames
if (node['name'] == node['dash']['prd_qydc_hostnames'][0] ||
    node['name'] == node['dash']['prd_lvdc_hostnames'][0] ||
    node['name'] == node['dash']['prf_qydc_hostnames'][0] ||
    node['name'] == node['dash']['prf_lvdc_hostnames'][0])
	node.override['dash']['default_job'] = 'true'
end
if node['dash']['default_job'] == 'true'
	node.override['dash']['resetDomoSchema'] = 'true'
end

#cachePeer is the name of the other node in a pair
default['dash']['cachePeer'] = nil
#prd_qydc
if (node['name'] == node['dash']['prd_qydc_hostnames'][0])
  default['dash']['cachePeer'] = node['dash']['prd_qydc_hostnames'][1]
elsif (node['name'] == node['dash']['prd_qydc_hostnames'][1])
  default['dash']['cachePeer'] = node['dash']['prd_qydc_hostnames'][0]
end
#prd_lvdc
if (node['name'] == node['dash']['prd_lvdc_hostnames'][0])
  default['dash']['cachePeer'] = node['dash']['prd_lvdc_hostnames'][1]
elsif (node['name'] == node['dash']['prd_lvdc_hostnames'][1])
  default['dash']['cachePeer'] = node['dash']['prd_lvdc_hostnames'][0]
end
#prf_qydc
if (node['name'] == node['dash']['prf_qydc_hostnames'][0])
  default['dash']['cachePeer'] = node['dash']['prf_qydc_hostnames'][1]
elsif (node['name'] == node['dash']['prf_qydc_hostnames'][1])
  default['dash']['cachePeer'] = node['dash']['prf_qydc_hostnames'][0]
end
#prd_lvdc
#if (node['name'] == node['dash']['prd_lvdc_hostnames'][0])
#  default['dash']['cachePeer'] = node['dash']['prd_lvdc_hostnames'][1]
#elsif (node['name'] == node['dash']['prd_lvdc_hostnames'][1])
#  default['dash']['cachePeer'] = node['dash']['prd_lvdc_hostnames'][0]
#end


####  SPLUNK  #######
default['dczone'] = node.environment.split("_").last
splunkindex = "sdlc-#{node['dczone'][0,3]}idx"

node.override['splunk']['forwarder']['url'] = 'http://sds-repo-int.qdc.intuit.com:8081/nexus/content/repositories/CTO.OPS-releases/com/intuit/CTO/OPS-releases/splunkforwarder/6.1.1/splunkforwarder-6.1.1-207789-linux-2.6-x86_64.rpm'
node.override['platform_chef-splunk']['logpaths'] = {
  "/opt/tomcat7/logs/catalina.out" => {
    'disabled' => 'false',
    'index' => splunkindex,
    'sourcetype' => 'apache',
    'blacklist' => '\.(gz)$'
  },
  "/opt/tomcat7/logs/dashboard*.log" => {
  	'disabled' => 'false',
  	'index' => splunkindex,
  	'sourcetype' => 'dashboard',
  	'blacklist' => '\.(gz)$'
  },
    "/var/log/httpd/access*" => {
  	'disabled' => 'false',
  	'index' => splunkindex,
  	'sourcetype' => 'apache',
  	'blacklist' => '\.(gz)$'
  },
    "/var/log/httpd/error*" => {
  	'disabled' => 'false',
  	'index' => splunkindex,
  	'sourcetype' => 'apache',
  	'blacklist' => '\.(gz)$'
  }
}

####  NEWRELIC  #######

node.override['platform_newrelic']['package_name'] = 'newrelic-sysmond'
node.override['platform_newrelic']['sysmond_version'] = '2.1.0.124-1'
node.override['platform_newrelic']['arch'] = 'x86_64'
node.override['platform_newrelic']['java_agent']['version'] = "3.26.1"
node.override['platform_newrelic']['java_agent']['https_url'] = "http://sds-repo-int.qdc.intuit.com:8081/nexus/content/repositories/CTO.OPS-releases/files/newrelic_java/newrelic-java-#{node['platform_newrelic']['java_agent']['version']}.zip"
node.override['platform_newrelic']['license'] = '1c95ae772ef70698d14f2fb116f6dcbb48069aba'
node.override['platform_newrelic']['java_agent']['install_path'] = '/opt/tomcat7'

default['dczone'] = node.environment.split("_").last
case node['dczone']
  when 'prdqye'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (prdqye); SDLC Dashboard (prd)'
  when 'prdlvb'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (prdlvb); SDLC Dashboard (prd)' 
  when 'prdqyc'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (prdqyc); SDLC Dashboard (prd)'
  when 'prdlva'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (prdlva); SDLC Dashboard (prd)'
  when 'prflva'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (prflva); SDLC Dashboard (prf)'
  when 'e2elva'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (e2elva); SDLC Dashboard (e2e)'
  when 'e2eqyc'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (e2eqyc); SDLC Dashboard (e2e)'
  when 'prfqyc'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (prfqyc); SDLC Dashboard (prf)'
  when 'qalqyc'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (qalqyc); SDLC Dashboard (qal)'
  when 'devqyc'
	node.override['platform_newrelic']['app_name'] = 'SDLC Dashboard (devqyc); SDLC Dashboard (dev)'
end
