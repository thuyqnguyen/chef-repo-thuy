file node['apache']['file']['name'] do
  owner 'root'
  mode 0644
  content "to be created if enable"
  action :create 
  only_if {node['apache']['file']['enable']}
# only_if ::File.exist?(/tmp/file/lock_file)
end
