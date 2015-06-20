
[![Build Status](https://travis-ci.org/retgoat/syncthing-ruby.svg?branch=master)](https://travis-ci.org/retgoat/syncthing-ruby)
[![Code Climate](https://codeclimate.com/github/retgoat/syncthing-ruby/badges/gpa.svg)](https://codeclimate.com/github/retgoat/syncthing-ruby)
[![Test Coverage](https://codeclimate.com/github/retgoat/syncthing-ruby/badges/coverage.svg)](https://codeclimate.com/github/retgoat/syncthing-ruby/coverage)

# Syncthing REST API bindings for Ruby

This gem provides bindings for [Syncthing](http://syncthing.net/) [REST API](http://docs.syncthing.net/dev/rest.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'syncthing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install syncthing

## Usage



**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|api_key|string|API key|Yes|
|api_url|string|Url to connect to. Default is localhost:8080|No|

Make a new instance of SyncthingClinet with API key and url — let's shake!

```ruby
2.1.2 :001 > sc = SyncthingClient.new('BO6406JTI3NH879QRHOGU840PL8702')
=> #<SyncthingClient:0x007ffb1f1102c0 @syncthing_url="https://localhost:8080/rest", @syncthing_apikey="BO6406JTI3NH879QRHOGU840PL8702"> 
```
###get_version

returns current version

```ruby
2.1.2 :002 > sc.get_version
=> {"arch"=>"amd64", "longVersion"=>"syncthing v0.11.9 (go1.4.2 darwin-amd64 default) unknown-user@syncthing-builder 2015-06-14 11:52:00 UTC", "os"=>"darwin", "version"=>"v0.11.9"} 
```

###get_connections

Returns current connections

```ruby
2.1.2 :003 > sc.get_connections
=> {"connections"=>{}, "total"=>{"address"=>"", "at"=>"2015-06-20T09:15:35.066466715+06:00", "clientVersion"=>"", "inBytesTotal"=>0, "outBytesTotal"=>0}} 
```

###get_config

Returns current syncthing config

```ruby
2.1.2 :004 > sc.get_config
=> {"version"=>10, "folders"=>[{"id"=>"123", "path"=>"/Users/retgoat/workspace/tapp", "devices"=>[{"deviceID"=>"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT"}], "readOnly"=>true, "rescanIntervalS"=>60, "ignorePerms"=>false, "autoNormalize"=>true, "versioning"=>{"type"=>"simple", "params"=>{"keep"=>"5"}}, "copiers"=>1, "pullers"=>16, "hashers"=>0, "order"=>"smallestFirst", "invalid"=>""}], "devices"=>[{"deviceID"=>"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT", "name"=>"iMac-Roman.local", "addresses"=>["dynamic"], "compression"=>"metadata", "certName"=>"", "introducer"=>false}], "gui"=>{"enabled"=>true, "address"=>"127.0.0.1:8080", "user"=>"", "password"=>"", "useTLS"=>true, "apiKey"=>"BO6406JTI3NH879QRHOGU840PL8702"}, "options"=>{"listenAddress"=>["0.0.0.0:22000"], "globalAnnounceServers"=>["udp4://announce.syncthing.net:22025"], "globalAnnounceEnabled"=>true, "localAnnounceEnabled"=>true, "localAnnouncePort"=>21025, "localAnnounceMCAddr"=>"[ff32::5222]:21026", "maxSendKbps"=>0, "maxRecvKbps"=>0, "reconnectionIntervalS"=>60, "startBrowser"=>true, "upnpEnabled"=>true, "upnpLeaseMinutes"=>60, "upnpRenewalMinutes"=>30, "upnpTimeoutSeconds"=>10, "urAccepted"=>1, "urUniqueId"=>"Dr9WJK-1", "restartOnWakeup"=>true, "autoUpgradeIntervalH"=>12, "keepTemporariesH"=>24, "cacheIgnoredFiles"=>true, "progressUpdateIntervalS"=>5, "symlinksEnabled"=>true, "limitBandwidthInLan"=>false, "databaseBlockCacheMiB"=>0}, "ignoredDevices"=>[]} 
```

###get_insync

Returns current insync condition

```ruby
2.1.2 :005 > sc.get_insync
=> {"configInSync"=>true}
```

###get_errors

Returns raised and not cleared errors

```ruby
sc.get_errors
=> {"errors"=>[]} 
```

###get_discovery

Returns local discovery hash

```ruby
2.1.2 :003 > sc.get_discovery
=> {} 
```

###new_error

Raises a new error with given message. Returns code 200 on success.

```ruby
sc.new_error('foo')
=> {:code=>200, :message=>"Completed successfully"}
```

###clear_errors

Clears previously rised errors. Returns code 200 on success.

```ruby
2.1.2 :005 > sc.clear_errors
=> {:code=>200, :message=>"Completed successfully"}
```

###new_config

Uploads a new config to syncthing server.

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|config|hash|New syncthing config|Yes|


```ruby
cfg = {"version"=>10, "folders"=>[{"id"=>"123", "path"=>"/Users/retgoat/workspace/tapp", "devices"=>[{"deviceID"=>"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT"}], "readOnly"=>true, "rescanIntervalS"=>60, "ignorePerms"=>false, "autoNormalize"=>true, "versioning"=>{"type"=>"simple", "params"=>{"keep"=>"5"}}, "copiers"=>1, "pullers"=>16, "hashers"=>0, "order"=>"smallestFirst", "invalid"=>""}], "devices"=>[{"deviceID"=>"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT", "name"=>"iMac-Roman.local", "addresses"=>["dynamic"], "compression"=>"metadata", "certName"=>"", "introducer"=>false}], "gui"=>{"enabled"=>true, "address"=>"127.0.0.1:8080", "user"=>"", "password"=>"", "useTLS"=>true, "apiKey"=>"BO6406JTI3NH879QRHOGU840PL8702"}, "options"=>{"listenAddress"=>["0.0.0.0:22000"], "globalAnnounceServers"=>["udp4://announce.syncthing.net:22025"], "globalAnnounceEnabled"=>true, "localAnnounceEnabled"=>true, "localAnnouncePort"=>21025, "localAnnounceMCAddr"=>"[ff32::5222]:21026", "maxSendKbps"=>0, "maxRecvKbps"=>0, "reconnectionIntervalS"=>60, "startBrowser"=>true, "upnpEnabled"=>true, "upnpLeaseMinutes"=>60, "upnpRenewalMinutes"=>30, "upnpTimeoutSeconds"=>10, "urAccepted"=>1, "urUniqueId"=>"Dr9WJK-1", "restartOnWakeup"=>true, "autoUpgradeIntervalH"=>12, "keepTemporariesH"=>24, "cacheIgnoredFiles"=>true, "progressUpdateIntervalS"=>5, "symlinksEnabled"=>true, "limitBandwidthInLan"=>false, "databaseBlockCacheMiB"=>0}, "ignoredDevices"=>[]}
 => {"version"=>10, "folders"=>[{"id"=>"123", "path"=>"/Users/retgoat/workspace/tapp", "devices"=>[{"deviceID"=>"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT"}], "readOnly"=>true, "rescanIntervalS"=>60, "ignorePerms"=>false, "autoNormalize"=>true, "versioning"=>{"type"=>"simple", "params"=>{"keep"=>"5"}}, "copiers"=>1, "pullers"=>16, "hashers"=>0, "order"=>"smallestFirst", "invalid"=>""}], "devices"=>[{"deviceID"=>"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT", "name"=>"iMac-Roman.local", "addresses"=>["dynamic"], "compression"=>"metadata", "certName"=>"", "introducer"=>false}], "gui"=>{"enabled"=>true, "address"=>"127.0.0.1:8080", "user"=>"", "password"=>"", "useTLS"=>true, "apiKey"=>"BO6406JTI3NH879QRHOGU840PL8702"}, "options"=>{"listenAddress"=>["0.0.0.0:22000"], "globalAnnounceServers"=>["udp4://announce.syncthing.net:22025"], "globalAnnounceEnabled"=>true, "localAnnounceEnabled"=>true, "localAnnouncePort"=>21025, "localAnnounceMCAddr"=>"[ff32::5222]:21026", "maxSendKbps"=>0, "maxRecvKbps"=>0, "reconnectionIntervalS"=>60, "startBrowser"=>true, "upnpEnabled"=>true, "upnpLeaseMinutes"=>60, "upnpRenewalMinutes"=>30, "upnpTimeoutSeconds"=>10, "urAccepted"=>1, "urUniqueId"=>"Dr9WJK-1", "restartOnWakeup"=>true, "autoUpgradeIntervalH"=>12, "keepTemporariesH"=>24, "cacheIgnoredFiles"=>true, "progressUpdateIntervalS"=>5, "symlinksEnabled"=>true, "limitBandwidthInLan"=>false, "databaseBlockCacheMiB"=>0}, "ignoredDevices"=>[]} 
2.1.2 :012 > sc.new_config cfg
=> {:code=>200, :message=>"Completed successfully"} 
```

###restart!

Will restart syncthing server

```ruby
2.1.2 :002 > sc.restart! => {"ok"=>"restarting"}
```

###reset!
This means renaming all repository directories to temporary, unique names, wiping all indexes and restarting. 

This should probably not be used during normal operations...

```ruby
sc.reset!
=> {"ok"=>"resetting database"}
```

###shutdown!

```ruby
sc.shutdown!
=> {"ok"=>"shutting down"}
```

###upgrade

Check for the new veersion

```ruby
2.1.2 :003 > sc.upgrade
 => {"latest"=>"v0.11.9", "majorNewer"=>false, "newer"=>false, "running"=>"v0.11.9"}
```

###upgrade!

Perform an upgrade and restart if new version exists. Does nothing if current version is latest.

```ruby
2.1.2 :003 > sc.upgrade!
 => {:code=>200, :message=>"Completed successfully"} 
```

###get_status

Returns current status

```ruby
2.1.2 :005 > sc.get_status
=> {"alloc"=>7061984, "cpuPercent"=>0.07942980406638137, "extAnnounceOK"=>{"udp4://announce.syncthing.net:22025"=>false}, "goroutines"=>58, "myID"=>"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT", "pathSeparator"=>"/", "sys"=>22104312, "tilde"=>"/Users/retgoat", "uptime"=>198} 
```

###get_ping

Returns a `{"ping":"pong"}` object

```ruby
2.1.2 :006 > sc.get_ping
=> {"ping"=>"pong"} 
```

###new_ping

Doing exactly the same as `get_ping` but API key is required (for `get_ping` it isn't). However, SyncthingClient is always using it. So, there is no difference between these two methods.

###browse_database

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|folder|string|Name of a database|Yes|
|level|int|Depth of a list. Default is `0` — maximum depth|No|
|prefix|string|Path to directory or subdirectory to start from|No|


Returns files in given folder

```ruby
2.1.2 :010 > sc.browse_databse '123'
 => {".rspec"=>["2014-07-18T18:42:16+07:00", 8], "Gemfile"=>["2015-06-16T08:09:23+06:00", 1267], "Gemfile.lock"=>["2015-06-16T08:09:27+06:00", 3224], "README.rdoc"=>["2014-04-29T15:40:52+07:00", 478], "Rakefile"=>["2014-04-29T15:40:52+07:00", 249], "app"=>{"assets"=>{"images"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "javascripts"=>{"application.js"=>["2014-04-29T15:40:52+07:00", 664], "index.js.coffee"=>["2014-04-29T15:42:29+07:00", 211]}, "stylesheets"=>{"application.css"=>["2014-04-29T15:40:52+07:00", 546], "index.css.scss"=>["2014-04-29T15:42:29+07:00", 176]}}, "controllers"=>{"application_controller.rb"=>["2014-04-29T15:40:52+07:00", 204], "concerns"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "index_controller.rb"=>["2015-04-28T14:10:00+06:00", 70]}, "helpers"=>{"application_helper.rb"=>["2014-04-29T15:40:52+07:00", 29], "index_helper.rb"=>["2014-04-29T15:42:29+07:00", 23]}, "mailers"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "models"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0], "Profile.rb"=>["2014-07-18T18:35:04+07:00", 244], "concerns"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}}, "views"=>{"index"=>{"index.html.erb"=>["2015-06-15T18:45:28+06:00", 8383]}, "layouts"=>{"application.html.erb"=>["2014-07-17T14:29:29+07:00", 399]}}}, "bin"=>{"bundle"=>["2014-04-29T15:40:52+07:00", 129], "rails"=>["2014-04-29T15:40:52+07:00", 146], "rake"=>["2014-04-29T15:40:52+07:00", 90]}, "config"=>{"application.rb"=>["2014-04-29T15:40:52+07:00", 981], "boot.rb"=>["2014-04-29T15:40:52+07:00", 171], "database.yml"=>["2014-04-29T15:40:52+07:00", 576], "environment.rb"=>["2014-04-29T15:40:52+07:00", 150], "environments"=>{"development.rb"=>["2015-04-28T14:09:54+06:00", 1484], "production.rb"=>["2014-04-29T15:40:52+07:00", 3248], "test.rb"=>["2014-04-29T15:40:52+07:00", 1558]}, "initializers"=>{"backtrace_silencers.rb"=>["2014-04-29T15:40:52+07:00", 404], "filter_parameter_logging.rb"=>["2014-04-29T15:40:52+07:00", 194], "inflections.rb"=>["2014-04-29T15:40:52+07:00", 647], "mime_types.rb"=>["2014-04-29T15:40:52+07:00", 205], "secret_token.rb"=>["2014-04-29T15:40:52+07:00", 658], "session_store.rb"=>["2014-04-29T15:40:52+07:00", 136], "wrap_parameters.rb"=>["2014-04-29T15:40:52+07:00", 517]}, "locales"=>{"en.yml"=>["2014-04-29T15:40:52+07:00", 634]}, "routes.rb"=>["2014-04-29T15:42:51+07:00", 1617]}, "config.ru"=>["2014-05-23T13:46:38+07:00", 154], "db"=>{"development.sqlite3"=>["2014-04-29T15:43:10+07:00", 0], "seeds.rb"=>["2014-04-29T15:40:52+07:00", 343], "test.sqlite3"=>["2014-07-18T18:43:42+07:00", 0]}, "lib"=>{"assets"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "tasks"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}}, "log"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0], "development.log"=>["2015-06-15T18:45:44+06:00", 1068452], "test.log"=>["2014-07-18T18:46:45+07:00", 388]}, "public"=>{"404.html"=>["2014-04-29T15:40:52+07:00", 1351], "422.html"=>["2014-04-29T15:40:52+07:00", 1334], "500.html"=>["2014-04-29T15:40:52+07:00", 1266], "favicon.ico"=>["2014-04-29T15:40:52+07:00", 0], "robots.txt"=>["2014-04-29T15:40:52+07:00", 204]}, "spec"=>{"models"=>{"profile_spec.rb"=>["2014-07-18T18:46:41+07:00", 204]}, "spec_helper.rb"=>["2014-07-18T18:42:16+07:00", 1643]}, "test"=>{"controllers"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0], "index_controller_test.rb"=>["2014-04-29T15:42:29+07:00", 162]}, "fixtures"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "helpers"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0], "index_helper_test.rb"=>["2014-04-29T15:42:29+07:00", 72]}, "integration"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "mailers"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "models"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "test_helper.rb"=>["2014-04-29T15:40:52+07:00", 492]}, "tmp"=>{"cache"=>{"assets"=>{"development"=>{"sass"=>{"89feb0728f707c47a29d048edba3bf45e1ee8d15"=>{"index.css.scssc"=>["2014-04-29T15:43:10+07:00", 628]}}, "sprockets"=>{"04b6ee5372eb476903f644a722c4a495"=>["2014-04-29T15:43:10+07:00", 398], "1093e36c1224ea4fe59ffdbc49d2b650"=>["2015-04-06T15:49:41+06:00", 283415], "13fe41fee1fe35b49d145bcc06610705"=>["2014-04-29T15:43:10+07:00", 922], "240ba0c0bcf617484d938fb7e77c612c"=>["2014-04-29T15:43:11+07:00", 19366], "2f5173deea6c795b8fdde723bb4b63af"=>["2015-04-06T15:49:41+06:00", 2425], "357970feca3ac29060c1e3861e2c0953"=>["2014-04-29T15:43:10+07:00", 922], "38ee972e64d80f83b2fb54fbfaa3d1f9"=>["2015-04-06T15:49:41+06:00", 16051], "41b411e5ea893da4b029d87c32e1c459"=>["2015-04-06T15:49:41+06:00", 283415], "665e3c6c09ff1386e81473b096af14a5"=>["2014-04-29T15:43:11+07:00", 699], "6f7cf560440e87c65a0e2bb4eafbd539"=>["2014-04-29T15:43:11+07:00", 16056], "7c50eb7a8092e60c53cf8040f3b6d7d9"=>["2014-04-29T15:43:11+07:00", 19366], "7f93ed4e723555db3219b6dcc1f38066"=>["2014-04-29T15:43:10+07:00", 283788], "86a2f746b74fd2fc1e1a2758c377976d"=>["2014-04-29T15:43:11+07:00", 16056], "9527d6c0ff83e08eb455eee782454eb8"=>["2014-04-29T15:43:11+07:00", 443], "97417525be96730f55e03b0e709d6cff"=>["2015-04-06T15:49:41+06:00", 16417], "97b02c9bfb861b59461dada7481ba655"=>["2015-04-06T15:49:41+06:00", 19361], "9a93606ff987b0e40fa2eab9807f1795"=>["2014-04-29T15:43:11+07:00", 283420], "a2200720e330965509460d82fe403934"=>["2014-04-29T15:43:10+07:00", 652], "b0475a0dc287fcb33712767b43f64830"=>["2015-04-06T15:49:41+06:00", 16051], "c05a25bd74345009c47e7f428bec1166"=>["2014-04-29T15:43:11+07:00", 19746], "cdbc1151dab8bde9a96ea4d6305964ce"=>["2015-04-06T15:49:41+06:00", 19361], "cffd775d018f68ce5dba1ee0d951a994"=>["2014-04-29T15:43:11+07:00", 318443], "d0f5e8d8a2b644f9d7e25eb746857689"=>["2014-04-29T15:43:10+07:00", 398], "d274fc4f3d6ee61a2eb6491ce44b8b5b"=>["2014-04-29T15:43:11+07:00", 283420], "d771ace226fc8215a3572e0aa35bb0d6"=>["2014-04-29T15:43:10+07:00", 1531], "e5fb54cb160fe0deabaa5df8f73edc3a"=>["2015-04-06T15:49:41+06:00", 283773], "f10381530f627eb50aa84a64c645accf"=>["2015-04-06T15:49:41+06:00", 19731], "f78c51de563675fb3abc0851a6644097"=>["2014-04-29T15:43:10+07:00", 16432], "f7cbd26ba1d28d48de824f0e94586655"=>["2015-04-06T15:49:41+06:00", 2425], "f925bbaa6d6a4ce22ba1f3fb2e416561"=>["2014-04-29T15:43:11+07:00", 443]}}}}, "pids"=>{}, "sessions"=>{}, "sockets"=>{}}, "vendor"=>{"assets"=>{"javascripts"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}, "stylesheets"=>{".keep"=>["2014-04-29T15:40:52+07:00", 0]}}}}
```

```ruby
2.1.2 :004 > sc.browse_databse '123', 0, 'app/assets/images'
=> {".keep"=>["2014-04-29T15:40:52+07:00", 0]} 
```

###get_completion

Returns completion in persentage (0-100) for given device and folder

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|device|string|device_id|Yes|
|folder|string|folder name|Yes|

```ruby
2.1.2 :005 > sc.get_completion '7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT', '123'
=> {"completion"=>0} 
```

###get_file

Returns info for given file

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|file|string|file name|Yes|


```ruby
2.1.2 :010 > sc.get_file 'README.md'
=> {"availability"=>nil, "global"=>{"flags"=>"0", "localVersion"=>0, "modified"=>"1970-01-01T07:00:00+07:00", "name"=>"", "numBlocks"=>0, "size"=>0, "version"=>[]}, "local"=>{"flags"=>"0", "localVersion"=>0, "modified"=>"1970-01-01T07:00:00+07:00", "name"=>"", "numBlocks"=>0, "size"=>0, "version"=>[]}}
```

###get_ignores

Returns ignores for given folder

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|folder|string|folder|Yes|


```ruby
2.1.2 :011 > sc.get_ignores '123'
=> {"ignore"=>[".DS_Store", ".gitignore"], "patterns"=>["(?i)^\\.DS_Store$", "(?i)^.*/\\.DS_Store$", "(?i)^\\.DS_Store/.*$", "(?i)^.*/\\.DS_Store/.*$", "(?i)^\\.gitignore$", "(?i)^.*/\\.gitignore$", "(?i)^\\.gitignore/.*$", "(?i)^.*/\\.gitignore/.*$"]} 
```

###new_ignores

Sets new ignores for given folder

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
| folder |string|folder|Yes|
|ingores|object|ignore object like in `get_ignores` response|Yes|


```ruby
2.1.2 :014 > ignores = {'ignore'=>['foo']}
=> {"ignore"=>["foo"]} 
2.1.2 :015 > sc.new_ignores '123', ignores
=> {"ignore"=>["foo"], "patterns"=>["(?i)^foo$", "(?i)^.*/foo$", "(?i)^foo/.*$", "(?i)^.*/foo/.*$"]} 
```

###need

Returns files which are needed for this device.

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|folder|string|folder|Yes|


```ruby
2.1.2 :016 > sc.get_need '123'
=> {"page"=>1, "perpage"=>65536, "progress"=>[], "queued"=>[], "rest"=>[], "total"=>0}  
```

###assign_priority

Assigns top priority for a given file in a given folder

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|folder|string|folder|Yes|
|file|string|filename|Yes|


```ruby
2.1.2 :017 > sc.assign_priority '123', 'README.md'
=> {"page"=>1, "perpage"=>65536, "progress"=>[], "queued"=>[], "rest"=>[], "total"=>0}
```

###scan

Request an immediate rescan of a folder with a subfolder

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|folder|string|folder|Yes|
|subfilder|string|subfilder name|No|


```ruby
2.1.2 :018 > sc.scan '123'
=> {:code=>200, :message=>"Completed successfully"} 

2.1.2 :019 > sc.scan '123', 'app/assets'
=> {:code=>200, :message=>"Completed successfully"} 
```

###get_folder_status

Returns status for a given folder

**Parameters**

|Name|Type|Description|Mandatory?|
|----|----|-----------|----------|
|folder|string|folder|Yes|


```ruby
2.1.2 :020 > sc.get_folder_status '123'
=> {"globalBytes"=>3370241, "globalDeleted"=>0, "globalFiles"=>148, "ignorePatterns"=>true, "inSyncBytes"=>3370241, "inSyncFiles"=>148, "invalid"=>"", "localBytes"=>3370241, "localDeleted"=>0, "localFiles"=>148, "needBytes"=>0, "needFiles"=>0, "state"=>"idle", "stateChanged"=>"2015-06-20T10:16:25.336122244+06:00", "version"=>150} 
```

###get_device_statistics

Returns device statistics

```ruby
2.1.2 :021 > sc.get_device_statistics
 => {"7OFMTQD-Q64DFR3-37DAZ4O-LFETQAM-FGIH46F-XGGXHFQ-EYLKOZR-HHLDUQT"=>{"lastSeen"=>"1970-01-01T07:00:00+07:00"}} 
```

###get_folder_statistics

Returns general statistics about folders.

```ruby
2.1.2 :022 > sc.get_folder_statistics
=> {"123"=>{"lastFile"=>{"at"=>"0001-01-01T00:00:00Z", "filename"=>""}}} 
```


## Contributing

1. Fork it ( https://github.com/retgoat/syncthing-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

##License
All code is licensed under the [MIT License.](https://github.com/retgoat/syncthing-ruby/blob/master/LICENSE.txt)

