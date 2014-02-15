require './app'
require 'sass/plugin/rack'

run Vuash::Application

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack
