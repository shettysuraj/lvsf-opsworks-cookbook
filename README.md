# lvsf-opsworks-cookbook

[![Circle CI](https://circleci.com/gh/LiveSafe/lvsf-opsworks-php-cookbook.svg?style=svg&circle-token=3e22a74258409188892fff680c6256a859a0576b)](https://circleci.com/gh/LiveSafe/lvsf-opsworks-php-cookbook) [![wercker status](https://app.wercker.com/status/2c48e40ece2552cd83e362ddbe0234f3/m "wercker status")](https://app.wercker.com/project/bykey/2c48e40ece2552cd83e362ddbe0234f3) [![Dependency Status](https://www.versioneye.com/user/projects/54be98bc6c0035208100002b/badge.svg?style=flat)](https://www.versioneye.com/user/projects/54be98bc6c0035208100002b)

Cookbook that brings up any of our PHP apps.

## Run Apps Locally

### Prep

Be sure you have kitchen and chef fully set up first - https://github.com/LiveSafe/livesafe-tech-wiki/wiki/Get-started-with-Chef


Install all the deps:
```bash
bundle install
berks install
```

### Run test suite

```bash
bundle exec strainer test --fail-fast
```

You can also check out `Strainerfile` to see what commands get run and run them manually.


### Deploy apps locally

In `.kitchen.yml`:

1. Uncomment the line with `- recipe[lvsf-opsworks-php-cookbook::deploy_local]`
1. Under `attributes -> deploy_local` add a hash for each app you wish to deploy.  E.g., if you want to deploy the php web services
```yml
    attributes:
      deploy_local:
        lvsf_php_services:
          git_url: 'git@github.com:LiveSafe/php-web-services.git'
          git_rev: 'master'
```
Then converge!

```bash
bundle exec kitchen converge
```

## Tested/Supported Platforms

Ubuntu 14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
</table>

## Usage

### lvsf-opsworks-php-cookbook::default

Include `lvsf-opsworks-php-cookbook` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[lvsf-opsworks-php-cookbook::default]"
  ]
}
```

## License and Authors

LiveSafe
MIT License
