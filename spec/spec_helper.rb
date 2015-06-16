require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'rspec'
require 'webmock/rspec'

require 'syncthing'

SimpleCov.start

ENV['CODECLIMATE_REPO_TOKEN'] = "6ffadacc3940d03c72501589d9a4f5d39109b669e892f4fda9eb5151ba429091"

WebMock.disable_net_connect!(:allow_localhost => true, :allow => "codeclimate.com")
