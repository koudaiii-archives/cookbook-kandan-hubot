require 'serverspec'

set :backend, :docker

set :docker_url, ENV['DOCKER_HOST']
set :docker_image, ENV['DOCKER_IMAGE']
set :path, '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH'
