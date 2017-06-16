my_file = '/tmp/myFile'

if MyFile.file_exists?(my_file)
  Chef::Log.info("1. The file #{my_file} exists")
  log("2. The file #{my_file} exists")
else
  Chef::Log.info("1. The file #{my_file} does not exists")
  log("2. The file #{my_file} does not exists")
  file my_file do
    content "hello, you\'re there"
  end
end

#content data_bag_item('data_bag', 'db_item')['key']
#content data_bag_item('data_bag', 'db_item')['id']
file "/tmp/user-thuy.json" do
  owner "root"
  group "root"
  mode 0644
  content data_bag_item('users', 'thuy').to_json
end

#get all node'ohai as json
file "/tmp/node.json" do
  owner "root"
  group "root"
  mode 0644
  content node.to_json
#  content node.attributes
#  content node.keys.sort.tojson
#  content node.ec2.to_json
# Get whatever attribute from the node
#  content node[:whatever_attr]

# all existing user account
#   node['etc']['passwd'].keys.sort
# Get the details of the root user:
#   node['etc']['passwd']['root']
end
