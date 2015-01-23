#
# Cookbook Name:: my_postfix
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "postfix"

# kandan app and postfix are in the same server
file "/etc/postfix/main.cf" do
  content lazy {
    _file = Chef::Util::FileEdit.new(path)
    _file.search_file_replace_line(/smtp/, "")
    content _file.send(:editor).lines.join
  }
end
