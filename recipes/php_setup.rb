#
# Cookbook Name:: lvsf-opsworks-cookbook
# Recipe:: php-setup
#
# Copyright (C) 2014 LiveSafe
#

include_recipe 'ohai'

include_recipe 'php5-fpm'
include_recipe 'php5-fpm::install'
include_recipe 'php5-fpm::create_user'
include_recipe 'php5-fpm::configure_pools'
include_recipe 'php5-fpm::configure_fpm'

include_recipe 'apt'
include_recipe 'nginx'

# For testing
%w(vim curl git).each do |pkg|
  package pkg do
    action :install
  end
end

# User/group modifications
group 'syslog' do
  action :manage
  append true
  members [node['lvsf_opsworks_php']['nginx_user']]
end

# setup php fpm
execute 'CGI Fix pathinfo' do
  command "sed 's/^;cgi\.fix_pathinfo=1$/cgi.fix_pathinfo=0/'"\
    " -i #{node['php_fpm']['base_path']}/php.ini"
  not_if "grep '^cgi\.fix_pathinfo=0$' #{node['php_fpm']['base_path']}/php.ini"
end

# setup nginx stuff
directory node['lvsf_opsworks_php']['php_app_srv_dir']  do
  owner node['lvsf_opsworks_php']['nginx_user']
  group node['lvsf_opsworks_php']['nginx_user']
  action :create
end

# enable our nginx config
template "#{node['nginx']['dir']}/sites-available/php-app" do
  source 'nginx/sites-available/php-app.erb'
end

link "#{node['nginx']['dir']}/sites-enabled/php-app" do
  to "#{node['nginx']['dir']}/sites-available/php-app"
end

[
  "#{node['nginx']['dir']}/sites-enabled/default",
  "#{node['nginx']['dir']}/sites-enabled/000-default"
].each do |symlink_path|
  link symlink_path do
    action :delete
  end
end

# basic app for testing
template "#{node['lvsf_opsworks_php']['php_app_srv_dir']}/info.php" do
  source 'info.php.erb'
  owner node['lvsf_opsworks_php']['nginx_user']
  group node['lvsf_opsworks_php']['nginx_user']
  mode '0770'
end

# restart services
service 'php5-fpm' do
  action :restart
  notifies :restart, 'service[nginx]', :delayed
end

service 'nginx' do
  action :restart
end
