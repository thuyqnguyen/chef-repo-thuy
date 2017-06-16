# use this to satisfy foodcritic

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else

  log "search data bags users"

  #search(:users, "*:*").each do |user|
  search(:users, "id:thuy").each do |user|
    log "id: #{user[:id]}, shell: #{user[:shell]}"
    Chef::Log.warn ("id: #{user[:id]}, shell: #{user[:shell]}")
  end 

  log "search role"
  search(:role, "*:*").each do |r|
    log "role: #{r}"
    Chef::Log.warn "role: #{r}"
  end

  log "search environment"
  search(:environment, "*:*").each do |e|
    log "environment name: #{e}"
    Chef::Log.warn "environment name: #{e}"
  end

  log "search node"
  #search(:node, "*:*").each do |n|
  #search(:node, 'platform:ubuntu AND name:thuy*').each do |n|
  #search(:node, "roles:web-server").each do |n|
  search(:node, "role:web-server").each do |n|
  # name is a method
    log "node name: #{n.name}, node role: #{n[:roles]}"
    Chef::Log.warn "node name: #{n.name}, node role: #{n[:roles]}"
  end
end
