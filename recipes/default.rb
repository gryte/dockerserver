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
firewall_rule 'kubernetes-api' do
  protocol :tcp
  port 6443
  command :allow
end

# open ports for Flannel VXLAN (K3s server and agent nodes)
firewall_rule 'flannel-vxlan' do
  protocol :udp
  port 8472
  command :allow
end

# open ports for kubelet (K3s server and agent nodes)
firewall_rule 'kubelet' do
  protocol :tcp
  port 10250
  command :allow
end

# open ports for Node driver Docker daemon TLS port
firewall_rule 'nd-drvr-dckr-dmn-tls-prt' do
  protocol :tcp
  port 2376
  command :allow
end

# open ports for etcd client requests
firewall_rule 'etcd-client-requests' do
  protocol :tcp
  port 2379
  command :allow
end

# open ports for etcd peer communication
firewall_rule 'etcd-peer-communication' do
  protocol :tcp
  port 2380
  command :allow
end

# open ports for Flannel livenessProbe/readinessProbe
firewall_rule 'flannel-livenessProbe-readinessProbe' do
  protocol :tcp
  port 9099
  command :allow
end

# open ports for Default port required by Monitoring to scrape metrics
firewall_rule 'monitoring-scrape-metrics' do
  protocol :tcp
  port 9796
  command :allow
end

# open ports for Weave Port
firewall_rule 'weave-port' do
  protocol :tcp
  port 6783
  command :allow
end

# open ports for Weave UDP Ports
firewall_rule 'weave-udp-ports' do
  protocol :udp
  port 6783..6784
  command :allow
end

# open ports for Ingress controller livenessProbe/readinessProbe
firewall_rule 'ingress-controller-livenessProbe-readinessProbe' do
  protocol :tcp
  port 10254
  command :allow
end

# open ports for NodePort port range TCP
firewall_rule 'nodeport-port-range-tcp' do
  protocol :tcp
  port 30000..32767
  command :allow
end

# open ports for NodePort port range UDP
firewall_rule 'nodeport-port-range-udp' do
  protocol :udp
  port 30000..32767
  command :allow
end

# open ports for traefik
firewall_rule 'traefik-443' do
  protocol :tcp
  port 443
  command :allow
end

# open ports for traefik
firewall_rule 'traefik-80' do
  protocol :tcp
  port 80
  command :allow
end

# open ports for traefik
firewall_rule 'traefik-8080' do
  protocol :tcp
  port 8080
  command :allow
end

# fix both CoreDNS and Traefik
# https://github.com/rancher/k3s/issues/24#issuecomment-475567218
firewall_rule 'fix-coredns' do
  raw 'ipv4 filter INPUT 1 -i cni0 -s 10.42.0.0/15 -j ACCEPT'
end

firewall_rule 'fix-traefik' do
  raw 'ipv4 filter FORWARD 1 -s 10.42.0.0/15 -j ACCEPT'
end

# pass traffic from docker0 interface
execute 'trust-docker0' do
  command 'firewall-cmd --permanent --zone=trusted --change-interface=docker0'
end

# restart firewalld
firewall 'default' do
  action :restart
end

# install docker-compose
remote_file '/usr/local/bin/docker-compose' do
  source node['dockerserver']['docker-compose']['install_url']
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# install rsync
package 'rsync' do
  action :install
end