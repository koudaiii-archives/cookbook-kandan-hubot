require 'spec_helper'

describe file('/etc/localtime') do
  it { should contain 'JST' }
end

describe file('/etc/sysconfig/i18n'), :if => os[:family] == 'redhat' do
  it { should contain 'ja_JP.UTF-8' }
end

describe file('/etc/default/locale'), :if => os[:family] == 'ubuntu' do
  it { should contain 'ja_JP.UTF-8' }
end

describe service('postfix') do
  it { should be_enabled }
end

describe service('postgresql') do
  it { should be_enabled }
end

describe command('/usr/local/rbenv/versions/1.9.3-p551/bin/gem list') do
   its(:stdout) { should match 'bundler' }
   its(:stdout) { should match 'execjs' }
   its(:stdout) { should match 'rbenv-rehash' }
end


#describe package('nginx') do
#  it { should be_installed }
#end
#
#describe service('nginx') do
#  it { should be_enabled }
#end

