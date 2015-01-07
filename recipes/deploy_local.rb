# Recipe for deploying an app on a local vm (not via opsworks)

directory '/root/.ssh' do
  action :create
end

execute 'Update known_hosts' do
  command 'ssh-keyscan github.com >> /root/.ssh/known_hosts'
end

# TODO: Use deploy resource (https://docs.getchef.com/resource_deploy.html)
node['deploy_local'].each do |app_name, app_repo|
  git "/tmp/#{app_name}" do
    repository app_repo['git_url']
    revision app_repo['git_rev']
    action :sync
  end

  bash 'copy deploy code' do
    code "cp -Rv /tmp/#{app_name}/* #{node['lvsf_opsworks_php']['php_app_srv_dir']}"
  end
end
