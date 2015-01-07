default['nginx']['worker_processes'] = node['cpu']['total']
default['nginx']['worker_connections'] = (20_480 / node['cpu']['total']).ceil
default['nginx']['worker_rlimit_nofile'] = 20_480
default['nginx']['multi_accept'] = 'on'

default['lvsf_opsworks_ingress_routing']['nginx_user'] = 'www-data'
