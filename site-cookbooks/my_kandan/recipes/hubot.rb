execute "start_boot_hubot" do
  action :run
  command "RAILS_ENV=production /usr/local/rbenv/shims/bundle exec rake kandan:boot_hubot"
  user node["kandan"]["user"]
  cwd "#{node['kandan']['path']}/current"
end

git "/opt/hubot" do
  repository node["kandan"]["hubot_git_repository"]
  action :sync
  revision "v2.4.7"
  user "root"
  group "root"
  not_if { ::File.directory?("/opt/hubot") }
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

script "install_hubot" do
  interpreter "bash"
  user        "root"
  code <<-EOL
    cd /opt/hubot/
    npm install
    npm install -g yo generator-hubot
    mkdir -p hubot
    yo hubot
    git clone https://github.com/kandanapp/hubot-kandan.git node_modules/hubot-kandan
    npm install faye
    npm install ntwitter
  EOL
end

file "/opt/hubot/node_modules/hubot-kandan/package.json" do
  content lazy {
    _file = Chef::Util::FileEdit.new(path)
    _file.search_file_replace_line(/\"1\.0\"/, "  \"version\"\:     \"1\.0\.0\"\,\n")
    content _file.send(:editor).lines.join
  }
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

