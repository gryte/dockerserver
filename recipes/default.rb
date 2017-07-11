#
# Cookbook Name:: dockerserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# enable platform default firewall
firewall 'default' do
  action :install
end

# add the yum repo
cookbook_file '/etc/yum.repos.d/docker.repo' do
  source 'docker.repo'
  action :create
end

# install docker
package 'docker-engine' do
  action :install
end

# enable and start docker service
service 'docker' do
  action [:enable, :start]
end

# install nfs-utils
package 'nfs-utils' do
  action :install
end

# open port for ssh connections
firewall_rule 'ssh' do
  port 22
  command :allow
end

# install docker-compose
remote_file '/usr/local/bin/docker-compose' do
  source "https://github.com/docker/compose/releases/download/1.14.0/docker-compose-#{node['os']}-#{node['packages']['kernel']['arch']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
