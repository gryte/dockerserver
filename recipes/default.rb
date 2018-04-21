#
# Cookbook Name:: dockerserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# enable platform default firewall
firewall 'default' do
  action :install
end

# Install required packages

yum_package %w(yum-utils device-mapper-persistent-data lvm2) do
  action :install
end

# add the stable docker-ce yum repo
yum_repository 'docker-ce-stable' do
  description 'Docker CE Stable - $basearch'
  baseurl 'https://download-stage.docker.com/linux/centos/7/$basearch/stable'
  enabled true
  gpgcheck true
  gpgkey 'https://download-stage.docker.com/linux/centos/gpg'
  repositoryid 'docker-ce'
end

# install docker-ce
yum_package 'docker-ce' do
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
