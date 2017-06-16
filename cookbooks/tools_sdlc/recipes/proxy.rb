#proxy.rb
#sets the intuit egress proxy for internet access

template '/etc/profile.d/proxy.sh' do
  source 'proxy.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :proxy => node[:dash][:proxy]
  )
end
