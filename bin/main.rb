#!/usr/bin/env ruby

require_relative '../lib/ruby_cutom_linter'


require 'strscan'

filenames = Dir.glob("sample/*.rb")
numberofFIles = filenames.length


i=0
while(i<numberofFIles) do
    file = File.open("#{filenames[i]}")
    file_data = file.read
    x=Lintermain.new(file_data,filenames[i])
    x.methodwarning
    x.classwarning
    x.loopIndent('class')
    i+=1
end
