require 'rubygems'
require 'bundler/setup'
require 'rack/less'

# Google Analytics: UNCOMMENT IF DESIRED, THEN ADD YOUR OWN ACCOUNT INFO HERE!
require 'rack/google-analytics'
use Rack::GoogleAnalytics, :tracker => "UA-51483940-1"

use Rack::Less,
  :source    => 'assets/less',
  :hosted_at => '/css'

require './app'
run Sinatra::Application