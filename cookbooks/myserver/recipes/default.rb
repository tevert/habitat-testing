#
# Cookbook Name:: myserver
# Recipe:: default
#
# Copyright 2016, centare
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

hab_install

package_path='/tmp/helloworld.hart'
s3_file package_path do
  s3_url 'https://s3-us-west-2.amazonaws.com/'
  bucket 'habitat-package-dump'
  remote_path 'centare/helloworld/latest.hart'
  aws_access_key_id 'AKIAJDVTVP5TJ5XTMP7A'
  aws_secret_access_key data_bag_item('habitat-secrets', 'aws-keys', IO.read('/var/local/chef_databag.key'))['AKIAJDVTVP5TJ5XTMP7A']
  notifies :install_package, "hab_package[#{package_path}]"
end

hab_package package_path do
  notifies :restart, 'service[habitat-helloworld]'
end

cookbook_file '/etc/init.d/habitat-helloworld' do
  source 'habitat-helloworld.sh'
  owner 'root'
  group 'root'
  mode 00755
end

service 'habitat-helloworld' do
  supports :status => true
  action [ :enable, :start ]
end
