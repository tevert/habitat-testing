name             'myserver'
maintainer       'centare'
maintainer_email 'tyler.evert@centare.com'
license          'MIT'
description      'Installs/Configures myserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.2'
supports         'ubuntu', '>= 12.04'

cookbook 'habitat', '~> 0.0.3'
