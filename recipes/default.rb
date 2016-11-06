#
# Cookbook Name:: dockerserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

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
