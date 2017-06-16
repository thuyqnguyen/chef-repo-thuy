# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "thuy_ws"
client_key               "#{current_dir}/thuy_ws.pem"
validation_client_name   "thuy-validator"
validation_key           "#{current_dir}/thuy-validator.pem"
chef_server_url          "https://api.chef.io/organizations/thuy"
cookbook_path            ["#{current_dir}/../cookbooks"]
