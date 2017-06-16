# chef special syntax
template '/tmp/greeting' do
  source 'test.erb'
  variables(
    greeter: node['apache']['greeter'],
    greeting: node['apache']['greeting']
  )
end

# or just use ruby hash
template '/tmp/greeting2' do
  source 'test.erb'
  variables(
    "greeter" => node['apache']['greeter'],
    "greeting" => node['apache']['greeting']
  )
end

