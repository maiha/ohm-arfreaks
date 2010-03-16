
require 'spec'
require 'rr'

Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

require 'ohm'
Ohm.connect(:port=>6380)        # this port number should be defined in redis.conf
Dir.glob(File.join(File.dirname(__FILE__), '/../lib/*.rb')).each{|lib| require lib}
require File.join(File.dirname(__FILE__), '/its_helper')
require File.join(File.dirname(__FILE__), '/provide_helper')
require File.join(File.dirname(__FILE__), '/model')

def path(key)
  Pathname(File.join(File.dirname(__FILE__) + "/fixtures/#{key}"))
end

def data(key)
  (@__fixture_data_cache__ ||= {})[key] ||= path(key).read{}
end
