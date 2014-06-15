$stdout.sync = true #enable logging in Heroku

require 'rubygems'
require 'bundler/setup'

require './app'
run Sinatra::Application