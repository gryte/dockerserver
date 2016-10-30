# docker package is installed
describe package('docker-engine') do
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
