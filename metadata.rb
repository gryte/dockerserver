name 'dockerserver'
maintainer 'Adam Linkous'
maintainer_email 'alinkous+support@gmail.com'
license 'MIT License'
description 'Installs/Configures dockerserver'
long_description 'Installs/Configures dockerserver'
version '1.2.0'
supports 'centos'
chef_version '~> 12.19' if respond_to?(:chef_version)
issues_url 'https://github.com/gryte/dockerserver/issues' if respond_to?(:issues_url)
source_url 'https://github.com/gryte/dockerserver' if respond_to?(:source_url)

depends 'firewall', '~> 2.6.1'
