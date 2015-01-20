execute "start_boot_hubot" do
  action :run
  command "RAILS_ENV=production /usr/local/rbenv/shims/bundle exec rake kandan:boot_hubot"
  user node["kandan"]["user"]
  cwd "#{node['kandan']['path']}/current"
end

remote_file "/opt/hubot.zip" do
  source node["kandan"]["hubot_download_url"]
  user node["kandan"]["user"]
  group node["kandan"]["user"]
  mode "0755"
end

script "install_hubot" do
  interpreter "bash"
  user        node["kandan"]["user"]
  code <<-EOL
    cd /opt/
    unzip hubot.zip
    cd /opt/hubot-2.4.7
    npm install
    make package
    cd hubot
    git clone https://github.com/kandanapp/hubot-kandan.git node_modules/hubot-kandan
    npm install faye
    npm install ntwitter
  EOL
  not_if { ::File.directory?("/opt/hubot-2.4.7") }
end
