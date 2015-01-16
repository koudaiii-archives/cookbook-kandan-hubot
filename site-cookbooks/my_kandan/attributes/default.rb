path = "/opt/kandan"
default["kandan"]["path"]           = path
default["kandan"]["repo"]           = "https://github.com/spesnova/kandan.git"
default["kandan"]["revision"]       = "v1.2"
default["kandan"]["user"]           = "kandan"
default["kandan"]["group"]          = "kandan"
default["kandan"]["bundle_command"] = nil
default["kandan"]["conf"]           = "#{path}/current/config/environments/production.rb"

# Database setting
default["kandan"]["database"]["host"]     = "localhost"
default["kandan"]["database"]["name"]     = "kandan_production"
default["kandan"]["database"]["username"] = "root"
default["kandan"]["database"]["password"] = "iloverandompasswordsbutthiswilldo"
default["kandan"]["database_master_role"] = "kandan_database_master"
