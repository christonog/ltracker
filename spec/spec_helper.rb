# name this file spec_helper.rb, and put it in the spec directory (root_of_app/spec/[file])

require File.join(File.dirname(__FILE__), '..', 'ltracker.rb')

require 'sinatra'
require 'rack/test'

#setup test environment

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
	Sinatra::Application
end

RSpec.configure do |config|
	config.include Rack::Test::Methods
	config.filter_run_excluding :broken => true #exclusion filter, exclude certain test groups from running
end