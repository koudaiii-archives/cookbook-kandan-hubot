#
# Cookbook Name:: my_kandan
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group 'kandan' do
  group_name 'kandan'
  system true
  action     [:create]
end

user 'kandan' do
  comment  'kandan'
  system true
  group    'kandan'
  home     '/home/kandan'
  shell    '/bin/bash'
  password nil
  supports :manage_home => true
  action   [:create, :manage]
end

git "/opt/kandan" do
  repository node["my_rbenv"]["ruby-build_url"]
  action :sync
  user "kandan"
  group "kandan"
end


