require 'strscan'
class Parser
    attr_accessor :methods
    attr_accessor :classes
    attr_accessor :nested
    def initialize(str)
        @buffer = StringScanner.new(str)
        @tags   = []
        parse
    end
    def find_function
        @buffer.getch
        functionname=@buffer.scan_until /def/
        print functionname
    end
    def find_tag
        @buffer.getch
        tag = @buffer.scan_until />/
        Tag.new(tag.chop)
    end
    def find_content
        tag = last_tag.name
        content = @buffer.scan_until /<\/#{tag}>/
        content.sub("</#{tag}>", "")
    end
    def parse_element
        if @buffer.peek(1) == '<'
          @tags << find_tag
          last_tag.content = find_content
        end
    end
    def parse
        until @buffer.eos?
          skip_spaces
          parse_element
        end
    end
end
class Tag
    attr_reader :name
    attr_accessor :content
    def initialize(name)
      @name = name
    end
end


#!/usr/bin/env ruby
filenames = Dir.glob("sample/*.rb")
print filenames[0]
file = File.open("#{filenames[0]}")
file_data = file.read
print file_data
print file_data.class
s = StringScanner.new(file_data)
dat=s.scan_until /def/
print dat.chomp('def')

