#
# Cookbook Name:: my_rbenv
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

%w{git curl}.each do |pkg|
  package pkg do
    action :install
  end
end

case node[:platform]
when "ubuntu", "debian"
  include_recipe "apt"
end

case node[:platform]
when "redhat", "centos", "amazon", "oracle"
  package "curl-devel"
  package "sqlite-devel"
  package "gcc"
  package "make"
  package "zlib"
  package "openssl"
  package "openssl-devel"
  package "zlib-devel"
  package "readline"
  package "readline-devel"
  package "libxml2-devel"
  package "libxslt-devel"
  package "gcc-c++"
  package "ImageMagick"
  package "ImageMagick-devel"
  package "mysql-devel"
  package "bzip2"
  package "libxml2"
  package "libxslt"
when "ubuntu", "debian"
  package "aptitude"
  package "libssl1.0.0"
  package "libc6-dev"
  package "automake"
  package "libtool"
  package 'libyaml-dev'
  package 'zlib1g'
  package 'zlib1g-dev'
  package "openssl"
  package 'libssl-dev'
  package "libreadline-dev"
  package "libxml2-dev"
  package "libxslt1-dev"
  package "ncurses-dev"
  package "pkg-config"
  package "build-essential"
  package "imagemagick"
  package "libmysqlclient-dev"
  package "bzip2"
#  package "zlib-devel"
  package "libxslt-dev"
  package "libxml2-dev"
end


git "/usr/local/rbenv" do
  repository node["my_rbenv"]["my_rbenv_url"]
  action :sync
end

%w{plugins shims versions}.each do |dir|
  directory "/usr/local/rbenv/#{dir}" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end
end

git "/usr/local/rbenv/plugins/ruby-build" do
  repository node["my_rbenv"]["ruby-build_url"]
  action :sync
  user "root"
  group "root"
end

git "/usr/local/rbenv/plugins/rbenv-default-gems" do
  repository node["my_rbenv"]["rbenv-default-gems"]
  action :sync
  user "root"
  group "root"
end

template "rbenv.sh" do
  source "rbenv.sh.erb"
  path "/etc/profile.d/rbenv.sh"
  mode 0644
  owner "root"
  group "root"
  not_if "grep rbenv /etc/profile.d/rbenv.sh"
end

template "default-gems" do
  source "default-gems.erb"
  path "/usr/local/rbenv/default-gems"
  mode 0755
  owner "root"
  group "root"
  not_if { File.exists?("/usr/local/rbenv/default-gems") }
end

include_recipe 'my_rbenv::ruby_install'
