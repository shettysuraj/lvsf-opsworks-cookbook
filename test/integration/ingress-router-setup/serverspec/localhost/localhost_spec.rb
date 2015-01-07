require 'spec_helper'

# Services
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

# Users/groups
describe user('www-data') do
  it { should belong_to_group 'syslog' }
end

# HTTP
describe port(80) do
  it { should be_listening.with('tcp') }
end

{
  'dashboard.hexxie.com' => /^You have reached: php$/,
  'services.hexxie.com' => /^You have reached: php$/,
  'services.hexxie.com/2/service/name' => /^You have reached: php$/,
  'services.hexxie.com/some/arbitrary/path' => /^You have reached: php$/,
  'services.hexxie.com/api/v3/resource/name' => /^You have reached: nodejs$/,
  'dev-services.hexxie.com/api/v3/resource/name' => /^You have reached: dev-nodejs$/,
  'staging-services.hexxie.com/api/v3/resource/name' => /^You have reached: staging-nodejs$/,
  'dev-services.hexxie.com/2/service/name' => /^You have reached: dev-php$/
}.each do |url_sans_proto, regex_matcher|
  describe command("curl http://#{url_sans_proto}") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(regex_matcher) }
  end
end
