[![Gem Version](https://badge.fury.io/rb/blockfrost-ruby.svg)](https://rubygems.org/gems/blockfrost-ruby)  <a href="https://fivebinaries.com/"><img src="https://img.shields.io/badge/made%20by-Five%20Binaries-darkviolet.svg?style=flat-square" /></a>

<img src="https://blockfrost.io/images/logo.svg" width="250" align="right" height="90">

# blockfrost-ruby

<br/>

<p align="center">Ruby SDK for <a href="https://blockfrost.io">Blockfrost.io</a> API.</p>
<p align="center">
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#development">Development</a>
</p>
<br>

## Installation

You can download the latest release directly from rubygems.org:

    $ gem install blockfrost-ruby

To build the current master, download this repo to your machine, then go to the directory:

    $ cd blockfrost-ruby

And run next commands:

    $ git add .
    $ gem build blockfrost-ruby
    $ gem install ./blockfrost-ruby-0.1.0.gem

That's it! You may use the gem in your projects.

## Usage

To use this SDK, you first need login into blockfrost.io and create your project to retrieve your API token.

And here are examples of how to use this SDK.

```ruby

require 'blockfrost-ruby'

blockfrost = Blockfrostruby::CardanoMainNet.new('your-API-key')
blockfrost.get_health
blockfrost.get_transaction('f6780212...36f0c20b6')

# The result of request is a hash object with keys [:status, :body]. Examples:
# {:status=>"200", :body=>{"is_healthy"=>true}}
# {:status=>"404", :body=>{"status_code"=>404, "error"=>"Not Found", "message"=>"The requested component has not been found."}}

# Requests which returns a list of result can be called with params.
# Allowed params are:
# :count, :page, :order, :from, :to     (the same as decribed in blockfrost docs)
# :from_page, :to_page, :parallel_requests, :sleep_between_retries_ms    (see below)

# Example of usage:
blockfrost.get_asset_history('81791e9e..1303035', { count: 50, page: 3, order: 'desc' })


# You may define what value should be used by default when you initialize the object.
config = { use_asc_order_as_default: false, default_count_per_page: 10 } # See the list of params below
blockfrost_configured = Blockfrostruby::CardanoMainNet.new('your-API-key', config)
blockfrost_configured.get_block_latest_transactions # will add order=asc&count=10 to request

# But you're still able to set params for specific action:
blockfrost_configured.get_block_latest_transactions({ count: 20 }) # will add order=asc&count=20 to request

# ==================
# ==================
# ==================

# On the other words:

# 1. Install the gem and require it

require 'blockfrost-ruby'


# 2. Initialize the object with the network:

blockfrost_mainnet = Blockfrostruby::CardanoMainNet.new('your-API-key')

# Or if you want to access other networks: 

blockfrost_testnet = Blockfrostruby::CardanoTestNet.new('your-API-key')
blockfrost_preview = Blockfrostruby::CardanoPreview.new('your-API-key')
blockfrost_preprod = Blockfrostruby::CardanoPreprod.new('your-API-key')
blockfrost_ipfs = Blockfrostruby::IPFS.new('your-API-key')


# 3. When you initialize, you may configure what params this object will use as default:

config = { default_count_per_page: 10 }
blockfrost = Blockfrostruby::CardanoMainNet.new('your-API-key', config)

# The list of values that can be defined in the config and its default values:

# config = {
#  use_asc_order_as_default: true    - the orders of lists will be asc by default
#  default_count_per_page: 100       - 100 items per page
#  parallel_requests: 10             - when fetching pages concurrently,
#                                      that param defines how many request
#                                      will be sent in one bunch
#  sleep_between_retries_ms: 500     - when you send too many concurent requests,
#                                      your account may reach the limit and the API will
#                                      start to answer you with 4xx statuses. This value
#                                      defines how long to wait between retries
# }


# 4. You may pass params explicitly for every request if that request accept params:

blockfrost.get_block_latest_transactions({ count: 20 })

# Allowed params are:
# :order, :page, :count, :from, :to - add ex. count= to the request
# :from_page, :to_page - when you want to get many pages you may define this params.
# Also note that you may define only :from_page and it will send requests until
# the not-nil response will be fetched.
# And 2 more params are:
# :parallel_requests, :sleep_between_retries_ms - the same as in config,
# but may be set directly to the request.

# Example of request:

blockfrost.get_list_of_next_blocks("hash_here", { count: 40, from_page: 11520, to_page: 11640, parallel_requests: 15 })

# That's it! Enjoy

```
All endpoints can be found here: https://docs.blockfrost.io/

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blockfrost/blockfrost-ruby.
