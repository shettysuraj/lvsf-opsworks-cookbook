pool_config = JSON.parse default['php_fpm']['pools']
pool_config['www']['user'] = 'www-data'
pool_config['www']['group'] = 'www-data'
pool_config['www']['listen'] = '/var/run/php5-fpm.sock'
pool_config['www']['listen.owner'] = 'www-data'
pool_config['www']['listen.group'] = 'www-data'
pool_config['www']['pm.max_children'] = 30
pool_config['www']['pm.min_spare_servers'] = 3
pool_config['www']['pm.max_spare_servers'] = 10

default['php_fpm']['pools'] = JSON.generate pool_config

default['nginx']['worker_processes'] = node['cpu']['total'] + 3

default['lvsf_opsworks_php']['nginx_user'] = 'www-data'
default['lvsf_opsworks_php']['php_app_srv_dir'] = '/var/www'
