#!/usr/bin/env ruby

# A script for parsing ERB templates that take advantage of our features.

require "erb"
require_relative "../ext.rb"

puts ERB.new(File.read(ARGV[0])).result
