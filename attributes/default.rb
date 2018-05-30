# manage docker-compose installation
default['dockerserver']['docker-compose']['base_url'] = 'https://github.com/docker/compose/releases/download/'
default['dockerserver']['docker-compose']['version'] = '1.21.2'
default['dockerserver']['docker-compose']['base_name'] = 'docker-compose'
default['dockerserver']['docker-compose']['os'] = node['kernel']['name']
default['dockerserver']['docker-compose']['arch'] = node['kernel']['machine']

default['dockerserver']['docker-compose']['install_url'] = "#{node['dockerserver']['docker-compose']['base_url']}#{node['dockerserver']['docker-compose']['version']}/#{node['dockerserver']['docker-compose']['base_name']}-#{node['dockerserver']['docker-compose']['os']}-#{node['dockerserver']['docker-compose']['arch']}"
