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

describe command('ruby -v') do
   its(:stderr) { should match /ruby 1\.9\.3-p551/ }
end

describe file('/usr/local/rbenv/versions/1.9.3-p551')do
  it { should be_directory }
end

describe package('rbenv-rehash') do
  it { should be_installed.by('gem') }
end

describe package('bundler') do
  it { should be_installed.by('gem') }
end

describe package('execjs') do
  it { should be_installed.by('gem') }
end


#describe package('nginx') do
#  it { should be_installed }
#end
#
#describe service('nginx') do
#  it { should be_enabled }
#end

