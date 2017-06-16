Chef::Resource::User.send(:include, Apache::Helper)

user 'thuy' do
  action :create
  only_if { has_phuong? }
end
