def load_current_resource
  @current_resource = Chef::Resource::MyresourceSite.new(@new_resource.name)
  if ::File.exist?('/var/www/html/index.html')
    @current_resource.homepage IO.read('/var/www/html/index.html')    
  end
end

action :create do  
    log("------- #{current_resource.homepage}")
    log("+++++++ #{new_resource.homepage}")
    if current_resource.homepage != new_resource.homepage 
      log("...... to be create")
      file '/var/www/html/index.html' do
        content new_resource.homepage
      end
      new_resource.updated_by_last_action(true)
    
    else
      log("xxxxxx Not create")
    end
end

action :delete do

end
