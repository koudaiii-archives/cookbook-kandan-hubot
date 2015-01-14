execute "run_updated_bash" do
  command "bash /etc/profile.d/rbenv.sh"
end

execute "rbenv install #{node['my_rbenv']['version']}" do
  command "export RBENV_ROOT='/usr/local/rbenv';/usr/local/rbenv/bin/rbenv install #{node['my_rbenv']['version']}"
  not_if { File.exists?("/usr/local/rbenv/versions/#{node['my_rbenv']['version']}")}
end

execute "rbenv global #{node['my_rbenv']['version']}" do
  command "export RBENV_ROOT='/usr/local/rbenv';/usr/local/rbenv/bin/rbenv global #{node['my_rbenv']['version']}"
end
