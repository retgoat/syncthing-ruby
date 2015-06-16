require "syncthing/version"
require "json"
require "net/http"

class SyncthingApiError < StandardError; end

class SyncthingClient
  ENDPOINTS = {
    # System endpoints
    :version => { :name=>'/system/version', :method => :get },
    :connections => { :name=>'/system/connections', :method => :get },
    :config => {
      :get => { :name=>'/system/config', :method => :get },
      :insync => { :name => '/system/config/insync', :method => :get },
      :new => { :name => '/system/config', :method => :post }
    },
    :system => {
      :restart => { :name => '/system/restart', :method => :post },
      :reset => { :name => '/system/reset', :method => :post },
      :shutdown => { :name => '/system/shutdown', :method => :post },
      :ping => { :name => '/system/ping', :method => :get },
      :upgrade => { :name => '/system/upgrade', :method => :get },
      :do_upgrade => { :name => '/system/upgrade', :method => :post },
      :status => { :name => '/system/status', :method => :get },
    },
    :errors => {
      :get => { :name => '/system/errors', :method => :get },
      :new => { :name => '/system/error', :method => :post },
      :clear => { :name => '/system/error/clear', :method => :post }
    },
    :discovery => {
     :get => { :name => '/system/discovery', :method => :get },
     :new => { :name => '/system/discovery/hint', :method => :post }
    },
    # Database endpoints
    :db => {
      :browse => { :name => '/db/browse', :method => :get },
      :completion => { :name => '/db/completion', :method => :get },
      :file => { :name => '/db/file', :method => :get },
      :ignores => { :name => '/db/ignores', :method => :get },
      :new_ignores => { :name => '/db/ignores', :method => :post },
      :need => { :name => '/db/need', :method => :get },
      :prio => { :name => '/db/prio', :method => :post },
      :scan => { :name => '/db/scan', :method => :post },
      :status => { :name => '/db/status', :method => :get },
    },
    # Statistics endpoints
    :stats => {
      :device => { :name => '/stats/device', :method => :get },
      :folder => { :name => '/stats/folder', :method => :get }
    }
  }

  def initialize (apikey, url = 'https://localhost:8080')
    @syncthing_url = "#{url}/rest"
    @syncthing_apikey = apikey
  end # initialize

  # System
  def get_version
    api_call(ENDPOINTS[:version])
  end

  def get_connections
    api_call(ENDPOINTS[:connections])
  end

  def get_config
    api_call(ENDPOINTS[:config][:get])
  end

  def get_insync
    api_call(ENDPOINTS[:config][:insync])
  end

  def get_errors
    api_call(ENDPOINTS[:errors][:get])
  end

  def get_discovery
    api_call(ENDPOINTS[:discovery][:get])
  end

  def new_error error_body
    api_call(ENDPOINTS[:errors][:new], { error: error_body.to_str }, false)
  end

  def clear_errors
    api_call(ENDPOINTS[:errors][:clear])
  end

  def new_discovery_hint(node, addr)
    api_call(ENDPOINTS[:discovery][:new], { node: node, addr: addr }, false)
  end

  def new_config config
    api_call(ENDPOINTS[:config][:new], config, false)
  end

  def restart!
    api_call(ENDPOINTS[:system][:restart])
  end

  def reset!
    api_call(ENDPOINTS[:system][:reset])
  end

  def shutdown!
    api_call(ENDPOINTS[:system][:shutdown])
  end

  def upgrade
    api_call(ENDPOINTS[:system][:upgrade])
  end

  def upgrade!
    api_call(ENDPOINTS[:system][:do_upgrade])
  end

  def get_status
    api_call(ENDPOINTS[:system][:status])
  end

  def get_ping
    api_call(ENDPOINTS[:system][:ping])
  end

  def new_ping
    get_ping
  end

  # Database
  def browse_databse folder, level = false
    params_string = "?folder=#{folder}"
    params_string << "&level=#{level}" if level
    api_call(ENDPOINTS[:db][:browse], false, params_string)
  end

  def get_completion device_id, folder
    api_call(ENDPOINTS[:db][:completion], false, "?device=#{device_id}&folder=#{folder}")
  end

  def get_file file
    api_call(ENDPOINTS[:db][:file], false, "?file=#{file}")
  end

  def get_ignores folder
    api_call(ENDPOINTS[:db][:ignores], false, "?folder=#{folder}")
  end

  def new_ignores folder, ignores
    api_call(ENDPOINTS[:db][:new_ignores], ignores, "?folder=#{folder}")
  end

  def get_need folder
    api_call(ENDPOINTS[:db][:need], false, "?folder=#{folder}")
  end

  def assign_priority folder, file
    api_call(ENDPOINTS[:db][:prio], false, "?folder=#{folder}&file=#{file}")
  end

  def scan folder, subfilder = false
    params_string = "?folder=#{folder}"
    params_string << "&sub=#{subfilder}" if subfilder
    api_call(ENDPOINTS[:db][:scan], false, params_string)
  end

  def get_folder_status folder
    api_call(ENDPOINTS[:db][:status], false, "?folder=#{folder}")
  end

  # Stats
  def get_device_statistics
    api_call(ENDPOINTS[:stats][:device])
  end

  def get_folder_statistics
    api_call(ENDPOINTS[:stats][:folder])
  end

  private

  def api_call(endpoint, request_body = false, params = false)
    url_string = @syncthing_url + endpoint[:name]
    url_string << params if params

    url = URI.parse(url_string)
    # construct the call data
    call = case endpoint[:method]
    when :post
      Net::HTTP::Post.new(url.request_uri, initheader = {'Content-Type' =>'application/json', 'User-Agent' => 'Syncthing Ruby client', 'X-API-Key'=>@syncthing_apikey})
    when :get
      Net::HTTP::Get.new(url.request_uri, initheader = {'Content-Type' =>'application/json', 'User-Agent' => 'Syncthing Ruby client', 'X-API-Key'=>@syncthing_apikey})
    else
      throw "Unknown call method #{endpoint[:method]}"
    end

    if request_body && !endpoint == ENDPOINTS[:config][:new]
      call.set_form_data(request_body)
    else
      call.body = request_body.to_json
    end

    request = Net::HTTP.new(url.host, url.port)

    request.read_timeout = 30
    usessl = @syncthing_url.match('https')
    request.use_ssl = usessl
    request.verify_mode = OpenSSL::SSL::VERIFY_NONE if usessl

    # make the call
    response = request.start {|http| http.request(call) }
    if response.code.to_i == 200
      if response.body.nil? || response.body.blank?
        { code: response.code.to_i, message: "Completed successfully"}
      else
        JSON.parse(response.body)
      end
    else
      raise SyncthingApiError.new("#{response.code} #{response.body.to_s}")
    end
  end # api_call

end # module
