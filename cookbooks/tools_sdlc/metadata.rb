name             'tools_sdlc'
maintainer       'Intuit Inc.'
maintainer_email 'Chitrang_Jain@intuit.com'
license          'All rights reserved'
description      'Installs/Configures tools_sdlc'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.64'

#depends 'platform_yum', '>= 2.0.0'
depends 'platform_java', '= 0.2.1'
#depends 'platform_httpd', '=2.0.0'
depends 'platform_tomcat', '= 0.1.7'
depends 'platform_chef-splunk', '= 2.0.20'
depends "platform_newrelic", '= 0.1.5'
#depends "infra_duo"

