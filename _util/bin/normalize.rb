#!/usr/bin/env ruby

require_relative "../lib/directory"
require_relative "../lib/project_file"
require "pathname"

path = Pathname.new(ARGV.first)

if path.directory?
  Directory.new(path)
else
  ProjectFile.for(path)
end.normalize!

