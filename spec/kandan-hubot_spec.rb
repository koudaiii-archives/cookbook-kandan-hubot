require 'spec_helper'

describe file('/etc/localtime') do
  it { should contain 'JST' }
end

#describe command('echo $LANG') do
#  its(:stderr) { should match /ja/ }
#end

#describe package('nginx') do
#  it { should be_installed }
#end
#
#describe service('nginx') do
#  it { should be_enabled }
#end

