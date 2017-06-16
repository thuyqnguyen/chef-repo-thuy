if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  servers = search(:node, "role:web-server")
  log ("list of servers under role web-server")
  servers.each do |server|
    log server.name
    log ("a web-server's name is #{server.name}")
  end
end
