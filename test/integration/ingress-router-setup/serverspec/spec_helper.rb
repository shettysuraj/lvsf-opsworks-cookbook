require 'serverspec'
require 'pathname'
require 'json'

set :backend, :exec

# SpecHelper - access test helpers
class SpecHelper
  class << self; attr_accessor :node end
  @node = ::JSON.parse(File.read('/tmp/serverspec/node.json'))
end
