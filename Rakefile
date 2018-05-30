desc 'Define default task'
task default: [:cookstyle, :foodcritic]

desc 'Run cookstyle'
task :cookstyle do
  sh 'cookstyle'
end

desc 'Run foodcritic in current directory'
task :foodcritic do
  sh 'foodcritic . --tags ~FC069 --tags ~FC078'
end

desc 'Berks upload dockerserver cookbook'
task :upload do
  sh 'berks upload'
end

desc 'Delete testserver node'
task :deletenode_test do
  sh 'knife node delete testserver -y'
end

desc 'Delete testserver client'
task :deleteclient_test do
  sh 'knife client delete testserver -y'
end

desc 'Remove testserver from chef server'
task remove_test: [:deletenode_test, :deleteclient_test]

desc 'Bootstrap test server'
task bootstrap_test: [:upload] do
  sh 'knife bootstrap 192.168.1.234 -E test -N testserver -r role[base_role],role[dockerserver_role] --sudo --ssh-user test --ssh-password test --use-sudo-password --bootstrap-version 14.1.1'
end
