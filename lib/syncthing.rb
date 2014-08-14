require "syncthing/version"
require "json"
require "net/http"

class SyncthingClient
  ENDPOINTS = {
    :version => {:name=>'/version', :method=>:get},
    :repo => {:name=>'/model', :method=>:get},
    :connections=>{:name=>'/connections', :method=>:get},
    :config => {
      :get => {:name=>'/config', :method=>:get},
      :sync => {:name=>'/config/sync', :method=>:get},
      :new => {:name=>'/config', :method=>:post}
    },
    :sync => {:name=>'/sync', :method=>:get},
    :system => {
      :get=> { :name=>'/system', :method=>:get},
      :restart => {:name=>'/restart', :method=>:post},
      :reset => {:name=>'/reset', :method=>:post},
      :shutdown => {:name=>'/shutdown', :method=>:post},
    },
    :errors => {
      :get => {:name=>'/errors', :method=>:get},
      :new => {:name=>'/error', :method=>:post},
      :clear=> {:name=>'/error/clear', :method=>:post}
    },
    :discovery => {
     :get=> {:name=>'/discovery', :method=>:get},
     :new => {:name=>'/discovery/hint', :method=>:post}
    }
  }

  def initialize (apikey, url)
    @syncthing_url = "#{url}/rest"
    @syncthing_apikey = apikey
  end # initialize

  def get_version
    api_call(ENDPOINTS[:version])
  end

  def get_repo repository = false
    api_call(ENDPOINTS[:repo], repository ? { repo: repository.to_s } : false, false)
  end

  def get_connections
    api_call(ENDPOINTS[:connections], false, false)
  end

  def get_config
    api_call(ENDPOINTS[:config][:get], false, false)
  end

  def get_sync
    api_call(ENDPOINTS[:config][:sync], false, false)
  end

  def get_system
    api_call(ENDPOINTS[:system][:get], false, false)
  end

  def get_errors
    api_call(ENDPOINTS[:errors][:get], false, false)
  end

  def get_discovery
    api_call(ENDPOINTS[:discovery][:get], false, false)
  end

  def new_error error_body
    api_call(ENDPOINTS[:errors][:new], { error: error_body.to_str }, false)
  end

  def clear_errors
    api_call(ENDPOINTS[:errors][:clear], false, false)
  end

  def new_discovery_hint(node, addr)
    api_call(ENDPOINTS[:discovery][:new], { node: node, addr: addr }, false)
  end

  def new_config config
    api_call(ENDPOINTS[:config][:new], config, false)
  end

  def restart!
    api_call(ENDPOINTS[:system][:restart], false, false)
  end

  def reset!
    api_call(ENDPOINTS[:system][:reset], false, false)
  end

  def shutdown!
    api_call(ENDPOINTS[:system][:shutdown], false, false)
  end

  def api_call(endpoint, request_body = false, params = false)
    url = URI.parse(@syncthing_url+endpoint[:name])
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

    unless response.body == nil or response.body == ""
      endpoint == ENDPOINTS[:version] ? response.body.to_str :  JSON.parse(response.body)
    end # unless
  end # api_call

end # module
