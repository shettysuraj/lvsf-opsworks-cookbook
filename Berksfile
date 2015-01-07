source 'https://supermarket.getchef.com'

metadata

cookbook 'apt', '~> 2.6.0'
cookbook 'php5-fpm', '0.3.3'
cookbook 'ohai', '~> 2.0.1'
cookbook 'nginx', '~> 2.7.4'

group :integration do
  cookbook 'test-helper', path: 'test/fixtures/cookbooks/test-helper'
end
