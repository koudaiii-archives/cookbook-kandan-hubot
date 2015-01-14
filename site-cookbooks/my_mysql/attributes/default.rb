default['my_mysql']['service_name'] = node['hostname']
default['my_mysql']['server_root_password'] = 'password'
default['my_mysql']['server_debian_password'] = 'password'
default['my_mysql']['data_dir'] = '/var/lib/mysql'
default['my_mysql']['port'] = '3306'
default['my_mysql']['version'] = '5.6'
#default['mysql']['server_package_version'] = '5.6.19-0ubuntu0.14.04.1'
### used in grants.sql
#default['my_mysql']['allow_remote_root'] = true
default['my_mysql']['remove_anonymous_users'] = true
default['my_mysql']['root_network_acl'] = nil
