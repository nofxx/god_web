require 'rubygems'
require 'god'
require 'sinatra'
require 'stringio'
require 'yaml'
require 'erb'
require 'optparse'
require File.dirname(__FILE__) + '/god_web'

config = {
  'god_port' =>  17165,
  'username' =>  nil,
  'password' =>  nil
}

begin
  config.merge!(YAML.load(File.read(ARGV[0])))
  GODWEB_CONFIG = config
rescue
  GODWEB_CONFIG = config
end
GODWEB = GodWeb.new(config)

# Require app
require File.dirname(__FILE__) + '/app'

Sinatra::Application.public = File.dirname(__FILE__) + "/../public"
Sinatra::Application.views = File.dirname(__FILE__) + "/../views"
