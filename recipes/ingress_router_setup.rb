#
# Cookbook Name:: lvsf-opsworks-ingress-routing-cookbook
# Recipe:: default
#
# Copyright (C) 2014 LiveSafe
#

include_recipe 'ohai'
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
  members [node['lvsf_opsworks_ingress_routing']['nginx_user']]
end

# enable our nginx config
template "#{node['nginx']['dir']}/sites-available/ingress-routing" do
  source 'nginx/sites-available/ingress-routing.erb'
end

link "#{node['nginx']['dir']}/sites-enabled/ingress-routing" do
  to "#{node['nginx']['dir']}/sites-available/ingress-routing"
end

[
  "#{node['nginx']['dir']}/sites-enabled/default",
  "#{node['nginx']['dir']}/sites-enabled/000-default"
].each do |symlink_path|
  link symlink_path do
    action :delete
  end
end

service 'nginx' do
  action :restart
end
