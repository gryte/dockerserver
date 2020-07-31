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

# open ports for Kubernetes API (K3s server nodes)
firewall_rule 'plex-htc-cmpn' do
  protocol :tcp
  port 6443
  command :allow
end

# open ports for Flannel VXLAN (K3s server and agent nodes)
firewall_rule 'bonjour-avahi' do
  protocol :udp
  port 8472
  command :allow
end

# open ports for kubelet (K3s server and agent nodes)
firewall_rule 'plex-htc-cmpn' do
  protocol :tcp
  port 10250
  command :allow
end

# install docker-compose
remote_file '/usr/local/bin/docker-compose' do
  source node['dockerserver']['docker-compose']['install_url']
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
