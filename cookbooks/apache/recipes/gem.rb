Chef::Log.info("starting...")

chef_gem 'ipaddress' do
  compile_time false
end
require 'ipaddress'

ip = IPAddress("192.168.0.3/24")
Chef::Log.info("Netmask of #{ip}: #{ip.netmask}")

