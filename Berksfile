source 'https://supermarket.chef.io' 

cookbook 'nginx'
cookbook 'timezone-ii'
cookbook 'mysql'
cookbook 'postgresql'
cookbook 'locale'

# WARN: Chef::Mixin::LanguageIncludeRecipe is deprecated, use Chef::DSL::IncludeRecipe
cookbook 'application_ruby', github: "poise/application_ruby"

cookbook 'my_locale', path: "./site-cookbooks/my_locale"
cookbook 'my_mysql', path: "./site-cookbooks/my_mysql"
cookbook 'my_postgresql', path: "./site-cookbooks/my_postgresql"
cookbook "my_rbenv", path: "./site-cookbooks/my_rbenv"
cookbook "my_postfix", path: "./site-cookbooks/my_postfix"
cookbook 'my_timezone', path: './site-cookbooks/my_timezone'
cookbook 'my_nginx', path: './site-cookbooks/my_nginx'
cookbook 'my_ntp', path: './site-cookbooks/my_ntp'
cookbook 'my_kandan', path: './site-cookbooks/my_kandan'
