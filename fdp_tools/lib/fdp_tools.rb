# frozen_string_literal: true

# FDP_INDEX = ENV['FDP_INDEX'] || 'https://tools.ostrails.eu/repositories/fdpindex-fdp'

require_relative './fdp_tools/version'
require 'sinatra'
require 'json'
require 'erb'
require 'uri'
require 'fileutils'

require 'require_all'
require_relative  'metadata_functions'
require_relative  'queries'
require_relative  'fdp'
require 'linkeddata'
require 'rest-client'
require 'sparql/client'

require 'rdf/vocab'

require_all '.'

module FdpTools
  class Error < StandardError; end
  # Your code goes here...
end
