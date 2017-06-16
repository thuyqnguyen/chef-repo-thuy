node.override['platform_newrelic']['java_agent']['version'] = '3.21.0'
node.override['platform_newrelic']['license'] = '92b542c11533ce59335c9b30c518db00e3bb0378'
default['dczone'] = node.environment.split("_").last
case node['dczone'][0,5]
  when 'e2eqy','e2elv'
node.override['platform_newrelic']['app_name'] = 'NEXUS_E2E'
node.override['platform_newrelic']['labels'] = 'app:NEXUS_E2E'
  when 'prfqy','prflv'
node.override['platform_newrelic']['app_name'] = 'NEXUS_PERF'
node.override['platform_newrelic']['labels'] = 'app:NEXUS_PERF'
  when 'prdqy','prdlv'
node.override['platform_newrelic']['app_name'] = 'NEXUS'
node.override['platform_newrelic']['labels'] = 'app:NEXUS'
end

node.override['platform_newrelic']['app_user'] = 'app'
node.override['platform_newrelic']['app_group'] = 'app'
#
