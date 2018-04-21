# docker package is installed
describe package('docker-ce') do
  it { should be_installed }
end

# docker service is running
describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# docker group exists
describe group('docker') do
  it { should exist }
end

# nfs-utils package is installed
describe package('nfs-utils') do
  it { should be_installed }
end

# firewalld service is enabled and running
describe service('firewalld') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# iptables is configured
describe iptables(chain: 'INPUT_direct') do
  it { should have_rule('-A INPUT_direct -p tcp -m tcp -m multiport --dports 22 -m comment --comment ssh -j ACCEPT') }
end

# docker-compose is installed
describe file('/usr/local/bin/docker-compose') do
  it { should exist }
  it { should be_executable }
end
