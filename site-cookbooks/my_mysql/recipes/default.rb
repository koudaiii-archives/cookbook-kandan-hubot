#
# Cookbook Name:: my_mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

mysql_service 'default' do
  version   "#{node['my_mysql']['version']}"
  package_version node['mysql']['server_package_version']
  port      "#{node['my_mysql']['port']}"
  data_dir  "#{node['my_mysql']['data_dir']}"
  allow_remote_root true
  root_network_acl node['my_mysql']['root_network_acl']
  remove_anonymous_users node['my_mysql']['remove_anonymous_users']
  remove_test_database  false
  server_root_password "#{node['my_mysql']['server_root_password']}"
  server_repl_password "#{node['my_mysql']['server_debian_password']}"
  server_debian_password "#{node['my_mysql']['server_debian_password']}"
  action :create
end

include_recipe 'mysql::server'
include_recipe 'mysql::client'

#template '/etc/mysql/conf.d/mysite.cnf' do
#    owner 'mysql'
#    owner 'mysql'
#    source 'mysite.cnf.erb'
#    notifies :restart, 'mysql_service[default]'
#end
