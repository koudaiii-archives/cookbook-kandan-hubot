#
# Cookbook Name:: my_kandan
# Recipe:: default
#
# Copyright (C) 2013 YOUR_COMPANY_NAME
# All rights reserved - Do Not Redistribute 
#

group node["kandan"]["group"] do
  group_name node["kandan"]["group"]
  system false
  action     [:create]
end

user node["kandan"]["user"] do
  comment node["kandan"]["user"]
  system false
  group node["kandan"]["group"]
  home "/home/#{node['kandan']['user']}"
  shell '/bin/bash'
  password nil
  supports :manage_home => true
  action   [:create, :manage]
end

%w{ tmp public config pids log }.each do |dir|
  directory "#{node['kandan']['path']}/shared/#{dir}" do
    owner node["kandan"]["user"]
    group node["kandan"]["user"]
    mode "0755"
    recursive true
  end
end


application "kandan" do
  action :deploy
  path node["kandan"]["path"]
  owner node["kandan"]["user"]
  group node["kandan"]["group"]
  environment_name "production"

  repository node["kandan"]["repo"]
  revision node["kandan"]["revision"]

  create_dirs_before_symlink %w{ log tmp public config pids }
  symlinks "pids" => "tmp/pids",
           "log"  => "log"


  rails do
    database_master_role node["kandan"]["database_master_role"] unless node["kandan"]["database"]["host"]
    database_template "custom_database.yml.erb" if node["kandan"]["database"]["host"]

    database_params = {
      :host     => node["kandan"]["database"]["host"],
      :name     => node["kandan"]["database"]["name"],
      :username => node["kandan"]["database"]["username"],
      :password => node["kandan"]["database"]["password"]
    }

    database do
      adapter  "pg"
      host     database_params[:host]
      database database_params[:name]
      username database_params[:username]
      password database_params[:password]
    end
  end
end

execute "bundle_install" do
  action :run
  command "/usr/local/rbenv/shims/bundle install"
  user node["kandan"]["user"]
  cwd "#{node['kandan']['path']}/current"
end

execute "bootstrap_kandan" do
  action :run
  command "RAILS_ENV=production /usr/local/rbenv/shims/bundle exec rake db:create db:migrate kandan:bootstrap"
  user node["kandan"]["user"]
  cwd "#{node['kandan']['path']}/current"
end

file node["kandan"]["conf"] do
  _file = Chef::Util::FileEdit.new(path)
  _file.search_file_replace_line(/config.serve_static_assets.*$/, "config.serve_static_assets = true")
  content _file.send(:editor).lines.join
end

execute "assets_precompile" do
  action :run
  command "RAILS_ENV=production /usr/local/rbenv/shims/bundle exec rake assets:precompile"
  user node["kandan"]["user"]
  cwd "#{node['kandan']['path']}/current"
end


execute "start_thin_for_kandan" do
  action :run
  command "/usr/local/rbenv/shims/bundle exec thin start -e production -p 80 -l log/thin.log -d"
  user node["kandan"]["user"]
  cwd "#{node['kandan']['path']}/current"
  not_if { ::File.exist?("#{node["kandan"]["path"]}/shared/pids/thin.pid") }
end

execute "restart_thin_for_kandan" do
  action :nothing
  command "/usr/local/rbenv/shims/bundle exec thin restart"
  user "root"
  cwd "#{node['kandan']['path']}/current"
end

