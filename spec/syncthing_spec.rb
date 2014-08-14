require 'spec_helper'

describe SyncthingClient do

  before(:each) do
    WebMock.reset!
  end

  before do
    @syncthing = SyncthingClient.new('QWERTYUIOP', 'http://testurl.com')
  end

  it 'should get syncthing version' do
    stub_request(:get, "http://testurl.com/rest/version").
      with(:body => "false",
        :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
      to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_version
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/version")
  end

  it 'should correctly handles timeout' do
    stub_request(:get, "http://testurl.com/rest/version").to_timeout
    expect{ @syncthing.get_version }.to(
      raise_error(Timeout::Error)
      ) 
  end

  it 'should get repository' do
    stub_request(:get, "http://testurl.com/rest/model").
    with(:body => "{\"repo\":\"test_repo\"}",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(
      :status => 200,
      :body => "",
      :headers => {}
      )
    @syncthing.get_repo 'test_repo'
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/model")
  end

  it 'should get connections' do
    stub_request(:get, "http://testurl.com/rest/connections").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
   to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_connections
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/connections")
  end

  it 'should get config' do
    stub_request(:get, "http://testurl.com/rest/config").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(:status => 200,
      :body => "",
      :headers => {})
    @syncthing.get_config
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/config")
  end

  it 'should get sync' do
    stub_request(:get, "http://testurl.com/rest/config/sync").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(:status => 200,
      :body => "",
      :headers => {})
    @syncthing.get_sync
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/config/sync")
  end

  it 'should get system' do
    stub_request(:get, "http://testurl.com/rest/system").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(:status => 200,
      :body => "",
      :headers => {})
    @syncthing.get_system
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system")
  end

  it 'should get discovery' do
    stub_request(:get, "http://testurl.com/rest/discovery").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(:status => 200,
      :body => "",
      :headers => {})
    @syncthing.get_discovery
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/discovery")
  end

  it 'should create a new error' do
    stub_request(:post, "http://testurl.com/rest/error").
         with(:body => "{\"error\":\"A new error\"}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_error 'A new error'
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/error")
  end

  it 'should get errors' do
    stub_request(:get, "http://testurl.com/rest/errors").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_errors
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/errors")
  end

  it 'should clear errors' do
    stub_request(:post, "http://testurl.com/rest/error/clear").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.clear_errors
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/error/clear")
  end

  it 'should create a new discovery hint' do
    stub_request(:post, "http://testurl.com/rest/discovery/hint").
         with(:body => "{\"node\":\"P56IOI7MZJNU2IQGDREYDM2MGTMGL3BXNPQ6W5BTBBZ4TJXZWICQ\",\"addr\":\"10.12.13.14:22000\"}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_discovery_hint('P56IOI7MZJNU2IQGDREYDM2MGTMGL3BXNPQ6W5BTBBZ4TJXZWICQ', '10.12.13.14:22000')
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/discovery/hint")
  end

  it 'should load a new config' do
    new_config = {"a"=>1, "b"=>2}
    stub_request(:post, "http://testurl.com/rest/config").
         with(:body => "{\"a\":1,\"b\":2}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_config new_config
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/config")
  end

  it 'should restart syncthing' do
    stub_request(:post, "http://testurl.com/rest/restart").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.restart!
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/restart")
  end

  it 'should reset syncthing' do
    stub_request(:post, "http://testurl.com/rest/reset").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.reset!
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/reset")
  end

  it 'should shutdown syncthing' do
    stub_request(:post, "http://testurl.com/rest/shutdown").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.shutdown!
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/shutdown")
  end

end
