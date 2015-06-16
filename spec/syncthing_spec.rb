require 'spec_helper'

describe SyncthingClient do

  before(:each) do
    WebMock.reset!
  end

  before do
    @syncthing = SyncthingClient.new('QWERTYUIOP', 'http://testurl.com')
  end

  it 'should get syncthing version' do
    stub_request(:get, "http://testurl.com/rest/system/version").
      with(:body => "false",
            :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
      to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_version
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/version")
  end

  it 'should correctly handles timeout' do
    stub_request(:get, "http://testurl.com/rest/system/version").to_timeout
    expect{ @syncthing.get_version }.to(
      raise_error(Timeout::Error)
      )
  end

  it 'should get connections' do
    stub_request(:get, "http://testurl.com/rest/system/connections").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
   to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_connections
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/connections")
  end

  it 'should get config' do
    stub_request(:get, "http://testurl.com/rest/system/config").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(:status => 200,
      :body => "",
      :headers => {})
    @syncthing.get_config
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/config")
  end

  it 'should get insync' do
    stub_request(:get, "http://testurl.com/rest/system/config/insync").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(:status => 200,
      :body => "",
      :headers => {})
    @syncthing.get_insync
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/config/insync")
  end

  it 'should get discovery' do
    stub_request(:get, "http://testurl.com/rest/system/discovery").
    with(:body => "false",
      :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
    to_return(:status => 200,
      :body => "",
      :headers => {})
    @syncthing.get_discovery
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/discovery")
  end

  it 'should create a new error' do
    stub_request(:post, "http://testurl.com/rest/system/error").
         with(:body => "{\"error\":\"A new error\"}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_error 'A new error'
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/error")
  end

  it 'should get errors' do
    stub_request(:get, "http://testurl.com/rest/system/errors").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_errors
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/errors")
  end

  it 'should clear errors' do
    stub_request(:post, "http://testurl.com/rest/system/error/clear").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.clear_errors
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/error/clear")
  end

  it 'should create a new discovery hint' do
    stub_request(:post, "http://testurl.com/rest/system/discovery/hint").
         with(:body => "{\"node\":\"P56IOI7MZJNU2IQGDREYDM2MGTMGL3BXNPQ6W5BTBBZ4TJXZWICQ\",\"addr\":\"10.12.13.14:22000\"}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_discovery_hint('P56IOI7MZJNU2IQGDREYDM2MGTMGL3BXNPQ6W5BTBBZ4TJXZWICQ', '10.12.13.14:22000')
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/discovery/hint")
  end

  it 'should load a new config' do
    new_config = {"a"=>1, "b"=>2}
    stub_request(:post, "http://testurl.com/rest/system/config").
         with(:body => "{\"a\":1,\"b\":2}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_config new_config
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/config")
  end

  it 'should restart syncthing' do
    stub_request(:post, "http://testurl.com/rest/system/restart").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.restart!
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/restart")
  end

  it 'should reset syncthing' do
    stub_request(:post, "http://testurl.com/rest/system/reset").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.reset!
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/reset")
  end

  it 'should shutdown syncthing' do
    stub_request(:post, "http://testurl.com/rest/system/shutdown").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.shutdown!
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/shutdown")
  end

  it "should get upgrade info" do
    stub_request(:get, "http://testurl.com/rest/system/upgrade").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.upgrade
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/upgrade")
  end

  it "should perform upgrade" do
    stub_request(:post, "http://testurl.com/rest/system/upgrade").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.upgrade!
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/upgrade")
  end

  it "should get status" do
    stub_request(:get, "http://testurl.com/rest/system/status").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_status
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/status")
  end

  it "should get ping" do
    stub_request(:get, "http://testurl.com/rest/system/ping").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_ping
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/ping")
  end

  it "should make new ping" do
    stub_request(:get, "http://testurl.com/rest/system/ping").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_ping
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/system/ping")
  end

  # DATABASE
  it "should browse database w/o level" do
    stub_request(:get, "http://testurl.com/rest/db/browse?folder=folder").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.browse_databse 'folder'
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/browse?folder=folder")
  end

  it "should browse database with level" do
    stub_request(:get, "http://testurl.com/rest/db/browse?folder=folder&level=0").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.browse_databse 'folder', 0
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/browse?folder=folder&level=0")
  end

  it "should get completion" do
    stub_request(:get, "http://testurl.com/rest/db/completion?device=ZYX&folder=fold").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_completion 'ZYX', 'fold'
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/completion?device=ZYX&folder=fold")
  end

  it "should get file" do
    stub_request(:get, "http://testurl.com/rest/db/file?file=filename").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_file 'filename'
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/file?file=filename")
  end

  it "should get ignores" do
    stub_request(:get, "http://testurl.com/rest/db/ignores?folder=fold").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_ignores 'fold'
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/ignores?folder=fold")
  end

  it "should add new ignores" do
    ignores = { 'a' => 1, 'b' => 3 }
    stub_request(:post, "http://testurl.com/rest/db/ignores?folder=fold").
         with(:body => "{\"a\":1,\"b\":3}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.new_ignores 'fold', ignores
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/ignores?folder=fold")
  end

  it "should get need" do
    stub_request(:get, "http://testurl.com/rest/db/need?folder=fold").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_need 'fold'
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/need?folder=fold")
  end

  it "should assign priority" do
    stub_request(:post, "http://testurl.com/rest/db/prio?folder=fold&file=file").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.assign_priority 'fold', 'file'
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/prio?folder=fold&file=file")
  end

  it "should perform scan w/o subfolder" do
    stub_request(:post, "http://testurl.com/rest/db/scan?folder=fold").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.scan 'fold'
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/scan?folder=fold&")
  end

  it "should perform scan with subfolder" do
    stub_request(:post, "http://testurl.com/rest/db/scan?folder=fold&sub=subf").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.scan 'fold', 'subf'
    expect(WebMock).to have_requested(:post, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/scan?folder=fold&sub=subf")
  end

  it "should get folder status" do
    stub_request(:get, "http://testurl.com/rest/db/status?folder=fold").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_folder_status 'fold'
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/db/status?folder=fold")
  end

  # STATS
  it "get device statistics" do
    stub_request(:get, "http://testurl.com/rest/stats/device").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_device_statistics
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/stats/device")
  end

  it "get folder statistics" do
    stub_request(:get, "http://testurl.com/rest/stats/folder").
         with(:body => "false",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Syncthing Ruby client', 'X-Api-Key'=>'QWERTYUIOP'}).
         to_return(:status => 200, :body => "", :headers => {})
    @syncthing.get_folder_statistics
    expect(WebMock).to have_requested(:get, "#{@syncthing.instance_variable_get(:@syncthing_url)}/stats/folder")
  end

end # SyncthingClient
