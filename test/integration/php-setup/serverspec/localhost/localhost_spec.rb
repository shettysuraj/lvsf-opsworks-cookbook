require 'spec_helper'

# Services
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe service('php5-fpm') do
  it { should be_enabled }
  it { should be_running }
end

# Users/groups
describe user('www-data') do
  it { should belong_to_group 'syslog' }
end

# Filesystem
describe file("#{SpecHelper.node['php_fpm']['base_path']}/php.ini") do
  it { should be_file }
  its(:content) { should match '^cgi\.fix_pathinfo=0$' }
end

describe file('/var/www/') do
  it { should be_directory }
  it { should be_owned_by 'www-data' }
  it { should be_grouped_into 'www-data' }
end

describe file('/var/run/php5-fpm.sock') do
  it { should be_socket }
  it { should be_owned_by 'www-data' }
  it { should be_grouped_into 'www-data' }
end

# HTTP
describe port(80) do
  it { should be_listening.with('tcp') }
end

describe command('curl http://localhost/info.php') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/phpinfo/) }
end
