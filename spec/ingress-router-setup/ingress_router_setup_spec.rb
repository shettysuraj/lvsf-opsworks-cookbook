require 'spec_helper.rb'

describe 'lvsf-opsworks-cookbook::ingress_router_setup' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge('lvsf-opsworks-cookbook::ingress_router_setup')
  end

  before(:each) do
    stub_command('which nginx').and_return(true)
    stub_command(/grep.*/).and_return(true)
  end

  it 'should include the apt recipe' do
    expect(chef_run).to include_recipe 'apt'
  end

  it 'should include the nginx recipe' do
    expect(chef_run).to include_recipe 'nginx::default'
  end

  it 'should add www-data to syslog group' do
    expect(chef_run).to manage_group('syslog')
  end

  it 'should restart the nginx service' do
    expect(chef_run).to restart_service 'nginx'
  end
end
