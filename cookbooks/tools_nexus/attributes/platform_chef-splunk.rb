node.override['splunk']['forwarder']['upgrade'] = false
#node.override['splunk']['forwarder']['url'] = 'http://sds-repo-int.qdc.intuit.com:8081/nexus/content/repositories/CTO.OPS-releases/com/intuit/CTO/OPS-releases/splunkforwarder/6.1.1/splunkforwarder-6.1.1-207789-linux-2.6-x86_64.rpm'
 
default['dczone'] = node.environment.split("_").last
splunkindex = "nexus-#{node['dczone'][0,3]}idx"

node.override['platform_chef-splunk']['logpaths'] = {
  "/app/nexus/ApacheNexusLogs/*.log" => {
    'disabled' => 'false',
    'index' => splunkindex,
    'sourcetype' => 'Apache',
    'blacklist' => '\.(gz)$'
  },
  
  "/var/log/remove_non_std_maven_versioned_artifacts/*.log" => {
    'disabled' => 'false',
    'index' => splunkindex,
    'sourcetype' => 'nexus',
    'blacklist' => '\.(gz)$'
  },
 
  "/app/nexus/sonatype-work/nexus/logs/*.log" => {
    'disabled' => 'false',
    'index' => splunkindex,
    'sourcetype' => 'nexus',
    'blacklist' => '\.(gz)$'
  },
 
  "/app/nexus/nexus/logs/*.log" => {
    'disabled' => 'false',
    'index' => splunkindex,
    'sourcetype' => 'nexus',
    'blacklist' => '\.(gz)$'
  },
  
  "/app/activemq/apache-activemq-5.8.0/data/*.log" => {
    'disabled' => 'false',
    'index' => splunkindex,
    'sourcetype' => 'activemq',
    'blacklist' => '\.(gz)$'
  }
  
}
