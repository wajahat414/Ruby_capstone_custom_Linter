#!/usr/bin/env ruby

require_relative '../lib/ruby_cutom_linter'

require 'strscan'
filenames = Dir.glob('test/*')
filelength = filenames.length

p 'by Default allowed method limit per file is 3 and classes,modules limit is 1  if you want to change enter 1 or 0 for default limits'
input = gets.chomp
if input == '1'
  p 'enter  limit of methods allowed per file'
  ml = gets.chomp
  p 'enter limit of classes allowed per file'
  cl = gets.chomp
  p 'enter limit of modules allowed per file'
  mol = gets.chomp
  ml = ml.to_i
  mol = mol.to_i
  cl = cl.to_i
end
i = 0
while i < filelength
  file = File.open((filenames[i]).to_s)
  file_data = file.read
  x = Lintermain.new(file_data, filenames[i])
  x.set_limits(ml, cl, mol) if input == '1'

  x.method_warning
  x.class_warning
  x.loop_indent('class')
  i += 1
end
