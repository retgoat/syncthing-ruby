# Syncthing REST API bindings for Ruby

This gem provides bindings for [Syncthing](http://syncthing.net/) [REST API](https://discourse.syncthing.net/t/v0-8-14-api-keys/335/)

## Installation

Add this line to your application's Gemfile:

    gem 'syncthing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install syncthing

## Usage

Make a new instance of SyncthingClinet with API key and url — let's shake!

```ruby
      sc = SyncthingClient.new('BO6406JTI3NH879QRHOGU840PL8702', 'http://localhost:8080')
      =>#<SyncthingClient:0x007f8310183108 @syncthing_url="http://localhost:8080/rest", @syncthing_apikey="BO6406JTI3NH879QRHOGU840PL8702">

      sc.get_version
      => "v0.8.21"

      #get repository info
      sc.get_repo('repo_name')
      #repo_name is optional. If blank `default' will be used
      => {"globalBytes"=>0, "globalDeleted"=>0, "globalFiles"=>0, "inSyncBytes"=>0, "inSyncFiles"=>0, "localBytes"=>0, "localDeleted"=>0, "localFiles"=>0, "needBytes"=>0, "needFiles"=>0, "state"=>"idle", "version"=>0}

      #get current connections
      sc.get_connections
      => {"total"=>{"At"=>"2014-07-28T15:22:23.610845338+07:00", "InBytesTotal"=>0, "OutBytesTotal"=>0, "Address"=>"", "ClientVersion"=>"", "Completion"=>0}} 

      #get current config        
      sc.get_config
      => {"Version"=>2, "Repositories"=>[{"ID"=>"default", "Directory"=>"/Users/retgoat/Sync", "Nodes"=>[{"NodeID"=>"7OFMTQDQ64DFR37DAZ4OLFETQAFGIH46FXGGXHFEYLKOZRHHLDUQ", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"", "Params"=>{}}, "SyncOrderPatterns"=>nil}, {"ID"=>"sc", "Directory"=>"~/sc", "Nodes"=>[{"NodeID"=>"7OFMTQDQ64DFR37DAZ4OLFETQAFGIH46FXGGXHFEYLKOZRHHLDUQ", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"simple", "Params"=>{"keep"=>"5"}}, "SyncOrderPatterns"=>nil}], "Nodes"=>[{"NodeID"=>"7OFMTQDQ64DFR37DAZ4OLFETQAFGIH46FXGGXHFEYLKOZRHHLDUQ", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>["dynamic"]}], "GUI"=>{"Enabled"=>true, "Address"=>"127.0.0.1:8080", "User"=>"", "Password"=>"", "UseTLS"=>false, "APIKey"=>"BO6406JTI3NH879QRHOGU840PL8702"}, "Options"=>{"ListenAddress"=>["0.0.0.0:22000"], "GlobalAnnServer"=>"announce.syncthing.net:22025", "GlobalAnnEnabled"=>true, "LocalAnnEnabled"=>true, "LocalAnnPort"=>21025, "ParallelRequests"=>160, "MaxSendKbps"=>0, "RescanIntervalS"=>600, "ReconnectIntervalS"=>600, "MaxChangeKbps"=>10000, "StartBrowser"=>true, "UPnPEnabled"=>true, "URAccepted"=>1}} 

      #returns whether the config is in sync, i.e. whether the running configuration is the same as that on disk.
      sc.get_sync
      => {"configInSync"=>true}

      #get current system status
      sc.get_system
      => {"alloc"=>4122136, "cpuPercent"=>0.052207200316129763, "extAnnounceOK"=>true, "goroutines"=>49, "myID"=>"7OFMTQDQ64DFR37DAZ4OLFETQAFGIH46FXGGXHFEYLKOZRHHLDUQ", "sys"=>10688760, "tilde"=>"/Users/retgoat"} 

      #returns local discovery hash
      sc.get_discovery
      => {} 

      #creates a new error. Error message will be shown on all GUI clients
      sc.new_error("This is a new error")
      => nil 

      #clear all errors
      sc.clear_errors
      => nil 

      #adds new discovery cache, params are: nodeId and address
      sc.new_discovery_hint('P56IOI7MZJNU2IQGDREYDM2MGTMGL3BXNPQ6W5BTBBZ4TJXZWICQ', '10.12.13.14:22000')
      => nil


      #get current errors
      sc.get_errors
      => [{"Time"=>"2014-07-28T15:24:58.431890258+07:00", "Error"=>"json: cannot unmarshal string into Go value of type config.Configuration\n"}, {"Time"=>"2014-07-28T15:25:32.350788025+07:00", "Error"=>"json: cannot unmarshal string into Go value of type config.Configuration\n"}]

      #set new config for syncthing
      #config must be provided as Ruby hash
      #restart syncthing after uploading a new config
      new_config = {"Version"=>2, "Repositories"=>[{"ID"=>"default", "Directory"=>"/Users/retgoat/Sync", "Nodes"=>[{"NodeID"=>"LGFPDIT7SKNNJVJZA4FC7QNCRKCE753K72BW5QD2FOZ7FRFEP57Q", "Name"=>"", "Addresses"=>nil}, {"NodeID"=>"USL2B3OM2CEOHG5GI2EM22OSOMT4LU6QAXJKZD2YKXFMO7EGBPEA", "Name"=>"", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"", "Params"=>{}}, "SyncOrderPatterns"=>nil}, {"ID"=>"sc", "Directory"=>"~/sc", "Nodes"=>[{"NodeID"=>"USL2B3OM2CEOHG5GI2EM22OSOMT4LU6QAXJKZD2YKXFMO7EGBPEA", "Name"=>"", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"simple", "Params"=>{"keep"=>"5"}}, "SyncOrderPatterns"=>nil}], "Nodes"=>[{"NodeID"=>"LGFPDIT7SKNNJVJZA4FC7QNCRKCE753K72BW5QD2FOZ7FRFEP57Q", "Name"=>"Test", "Addresses"=>["192.162.129.11:22000"]}, {"NodeID"=>"USL2B3OM2CEOHG5GI2EM22OSOMT4LU6QAXJKZD2YKXFMO7EGBPEA", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>["dynamic"]}], "GUI"=>{"Enabled"=>true, "Address"=>"127.0.0.1:8080", "User"=>"", "Password"=>"", "UseTLS"=>false, "APIKey"=>"BO6406JTI3NH879QRHOGU840PL8702"}, "Options"=>{"ListenAddress"=>["0.0.0.0:22000"], "GlobalAnnServer"=>"announce.syncthing.net:22025", "GlobalAnnEnabled"=>true, "LocalAnnEnabled"=>true, "LocalAnnPort"=>21025, "ParallelRequests"=>160, "MaxSendKbps"=>0, "RescanIntervalS"=>600, "ReconnectIntervalS"=>600, "MaxChangeKbps"=>10000, "StartBrowser"=>true, "UPnPEnabled"=>true, "URAccepted"=>1}}
      => {"Version"=>2, "Repositories"=>[{"ID"=>"default", "Directory"=>"/Users/retgoat/Sync", "Nodes"=>[{"NodeID"=>"LGFPDIT7SKNNJVJZA4FC7QNCRKCE753K72BW5QD2FOZ7FRFEP57Q", "Name"=>"", "Addresses"=>nil}, {"NodeID"=>"USL2B3OM2CEOHG5GI2EM22OSOMT4LU6QAXJKZD2YKXFMO7EGBPEA", "Name"=>"", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"", "Params"=>{}}, "SyncOrderPatterns"=>nil}, {"ID"=>"sc", "Directory"=>"~/sc", "Nodes"=>[{"NodeID"=>"USL2B3OM2CEOHG5GI2EM22OSOMT4LU6QAXJKZD2YKXFMO7EGBPEA", "Name"=>"", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"simple", "Params"=>{"keep"=>"5"}}, "SyncOrderPatterns"=>nil}], "Nodes"=>[{"NodeID"=>"LGFPDIT7SKNNJVJZA4FC7QNCRKCE753K72BW5QD2FOZ7FRFEP57Q", "Name"=>"Test", "Addresses"=>["192.162.129.11:22000"]}, {"NodeID"=>"USL2B3OM2CEOHG5GI2EM22OSOMT4LU6QAXJKZD2YKXFMO7EGBPEA", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>["dynamic"]}], "GUI"=>{"Enabled"=>true, "Address"=>"127.0.0.1:8080", "User"=>"", "Password"=>"", "UseTLS"=>false, "APIKey"=>"BO6406JTI3NH879QRHOGU840PL8702"}, "Options"=>{"ListenAddress"=>["0.0.0.0:22000"], "GlobalAnnServer"=>"announce.syncthing.net:22025", "GlobalAnnEnabled"=>true, "LocalAnnEnabled"=>true, "LocalAnnPort"=>21025, "ParallelRequests"=>160, "MaxSendKbps"=>0, "RescanIntervalS"=>600, "ReconnectIntervalS"=>600, "MaxChangeKbps"=>10000, "StartBrowser"=>true, "UPnPEnabled"=>true, "URAccepted"=>1}}        new_config = {"Version"=>2, "Repositories"=>[{"ID"=>"default", "Directory"=>"/Users/retgoat/Sync", "Nodes"=>[{"NodeID"=>"7OFMTQDQ64DFR37DAZ4OLFETQAFGIH46FXGGXHFEYLKOZRHHLDUQ", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"", "Params"=>{}}, "SyncOrderPatterns"=>nil}, {"ID"=>"sc", "Directory"=>"~/sc", "Nodes"=>[{"NodeID"=>"7OFMTQDQ64DFR37DAZ4OLFETQAFGIH46FXGGXHFEYLKOZRHHLDUQ", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>nil}], "ReadOnly"=>false, "IgnorePerms"=>false, "Invalid"=>"", "Versioning"=>{"Type"=>"simple", "Params"=>{"keep"=>"5"}}, "SyncOrderPatterns"=>nil}], "Nodes"=>[{"NodeID"=>"7OFMTQDQ64DFR37DAZ4OLFETQAFGIH46FXGGXHFEYLKOZRHHLDUQ", "Name"=>"MacBook-Pro-Roman.local", "Addresses"=>["dynamic"]}], "GUI"=>{"Enabled"=>true, "Address"=>"127.0.0.1:8080", "User"=>"", "Password"=>"", "UseTLS"=>false, "APIKey"=>"BO6406JTI3NH879QRHOGU840PL8702"}, "Options"=>{"ListenAddress"=>["0.0.0.0:22000"], "GlobalAnnServer"=>"announce.syncthing.net:22025", "GlobalAnnEnabled"=>true, "LocalAnnEnabled"=>true, "LocalAnnPort"=>21025, "ParallelRequests"=>160, "MaxSendKbps"=>0, "RescanIntervalS"=>600, "ReconnectIntervalS"=>600, "MaxChangeKbps"=>10000, "StartBrowser"=>true, "UPnPEnabled"=>true, "URAccepted"=>1}}
      sc.new_config(new_config)
      => nil 

      #restarting syncthing daemon
      sc.restart!
      => {"ok"=>"restarting"} 

      #reset syncing. 
      #This means renaming all repository directories to temporary, unique names, wiping all indexes and restarting. 
      #This should probably not be used during normal operations...
      sc.reset!
      => {"ok"=>"resetting repos"}

      #shut down syncthing
      sc.shutdown!
      => {"ok"=>"shutting down"}

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/syncthing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
