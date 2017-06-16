ENV['MESSAGE'] = 'Hello from Chef. How are you'

execute "print value of environment variable $MESSAGE" do
  command 'echo ${MESSAGE} > /tmp/message'
  environment :MESSAGE => 'Hello from me. I override the setting of ENV[MESSAGE]'
end

#passing variable to execute command

memory = node['memory']['total']
execute "print out the memory" do
  command <<EOC
  echo "the total memory is: #{memory}"
  echo #{memory} > /tmp/totalmem
EOC
end
