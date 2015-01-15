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

#describe package('nginx') do
#  it { should be_installed }
#end
#
#describe service('nginx') do
#  it { should be_enabled }
#end

