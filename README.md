# Syncthing

Provides bindings for Syncthing REST API 

## Installation

Add this line to your application's Gemfile:

    gem 'syncthing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install syncthing

## Usage

Make a new instance of SyncthingClinet with API key and url

```ruby
        sc = SyncthingClient.new('APIKEY', 'URL')
        =>#<SyncthingClient:0x007f8310183108 @syncthing_url="http://localhost:8080/rest", @syncthing_apikey="BO6406JTI3NH879QRHOGU840PL8702">

        sc.get_version
        #=> "v0.8.21" 
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/syncthing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
