#!/usr/bin/env ruby

require "erb"
require_relative "ext"

puts ERB.new(File.read(ARGV[0])).result
