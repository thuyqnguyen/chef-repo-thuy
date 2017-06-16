remote_directory '/tmp/remote_test_dir' do
  source 'remote_dir'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

