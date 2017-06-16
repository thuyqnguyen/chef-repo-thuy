ruby_block 'set permissions for tomcat dir' do
  block do
    require 'fileutils'
    FileUtils.chown_R 'tomcat', 'tomcat', '/opt/tomcat7'
  end
  action :run
  notifies :restart, 'service[tomcat7]', :delayed
end
