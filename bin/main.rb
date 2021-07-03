#!/usr/bin/env ruby

require_relative '../lib/ruby_cutom_linter'

require 'strscan'

filenames = Dir.glob('sample/*.rb')
filelength = filenames.length

i = 0
while i < filelength
  file = File.open((filenames[i]).to_s)
  file_data = file.read
  x = Lintermain.new(file_data, filenames[i])
  x.methodwarning
  x.classwarning
  x.loopindent('class')
  i += 1
end
