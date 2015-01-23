execute "start_boot_hubot" do
  action :run
  command "RAILS_ENV=production /usr/local/rbenv/shims/bundle exec rake kandan:boot_hubot"
  user node["kandan"]["user"]
  cwd "#{node['kandan']['path']}/current"
end

git "/opt/hubot" do
  repository node["hubot"]["repo"]
  action :sync
  revision node["hubot"]["revision"]
  user "root"
  group "root"
  not_if { ::File.directory?("/opt/hubot") }
end

directory '/opt/hubot/node_modules' do
  owner 'root'
  group 'root'
  mode '0755'
end

directory "/opt/hubot/hubot" do
  owner "root"
  group "root"
  mode '0755'
end

git "/opt/hubot/node_modules/hubot-kandan" do
  repository node["hubot-kandan"]["repo"]
  action :sync
  revision node["hubot-kandan"]["revision"]
  user "root"
  group "root"
  not_if { ::File.directory?("/opt/hubot/node_modules/hubot-kandan") }
end

# Fix npm error when booting hubot
# https://github.com/uk-ar/hubot-kandan/commit/070a90137c1bd9215765b4c1ff30184b56eb3dea
file "/opt/hubot/node_modules/hubot-kandan/package.json" do
  content lazy {
    _file = Chef::Util::FileEdit.new(path)
    _file.search_file_replace_line(/\"1\.0\"/, "  \"version\"\:     \"1\.0\.0\"\,\n")
    content _file.send(:editor).lines.join
  }
end

# ubuntu:ERR usr/bin/env: node: No such file or directory
# because legacy node
case node[:platform]
when "redhat", "centos", "amazon", "oracle"
# not running
when "ubuntu", "debian"
  execute "lebacy_node" do
    command "ln -s /usr/bin/nodejs /usr/local/bin/node"
    user "root"
  end
end

# git clone https://github.com/kandanapp/hubot-kandan.git node_modules/hubot-kandan
script "install_hubot" do
  interpreter "bash"
  user        "root"
  code <<-EOL
    cd /opt/hubot/
    npm install
    npm install -g yo generator-hubot
    yo hubot
    npm install faye
    npm install ntwitter
  EOL
end

# TODO npm install forever -g
template "hubot.sh" do
 source "hubot.sh.erb"
 path "/opt/hubot/hubot.sh"
 mode 0755
 owner
 group
 not_if { File.exist?("/opt/hubot/hubot.sh") }
end

cron "auto_run_hubot" do
  minute '*'
  hour '*'
  weekday '*'
  user "root"
  path "/usr/local/rbenv/shims:/usr/local/rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
  command "cd /opt/hubot;sh /opt/hubot/hubot.sh start"
end
