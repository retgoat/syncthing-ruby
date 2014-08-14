require 'rspec'
require 'webmock/rspec'

require 'syncthing'

WebMock.disable_net_connect!(:allow_localhost => true)
