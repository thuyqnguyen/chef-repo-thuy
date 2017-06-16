def whyrun_supported?
  true
end

action :create do
#  converge_if_changed :content do
    IO.write(new_resource.path, new_resource.content)
    new_resource.updated_by_last_action(true)
#  end
#  converge_if_changed :mode do
#    File.chmod(mode, path)
#  end
end
