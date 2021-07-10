# rubocop: disable Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/CyclomaticComplexity

# Description/Explanation of Main class
class Lintermain
  attr_accessor :buffer, :loopcount, :methodlimit, :methodnamelimit, :classlimit, :modulelimit, :classnamelimit,
                :filename, :count_modules, :count_classes, :count_methods

  def initialize(buffer, filename)
    @buffer = buffer
    @loopcount = 0
    @methodlimit = 3
    @classlimit = 1
    @methodnamelimit = 5
    @classnamelimit = 5
    @filename = filename
    @modulelimit = 2
  end

  def set_limits(methodlimit, classlimit, modulelimit)
    @methodlimit = methodlimit
    @classlimit = classlimit
    @modulelimit = modulelimit
  end

  def method_warning
    methodcount = count_methods
    if methodcount > @methodlimit
      r = methodcount - @methodlimit
      p "There are #{r} excessive method in file #{@filename}"
    end
    r
  end

  def class_warning
    classcount = count_classes
    if classcount > @classlimit
      r = classcount - @classlimit
      p "There are #{r} excessive classes in file #{@filename}"
    end
    r
  end

  def module_warning
    modulecount = count_modules
    if modulecount > @modulelimit
      r = modulecount - @modulelimit
      p "There are #{r} excessive modules in file #{@filename}"
    end
    r
  end

  def loop_indent(tocheck = nil)
    file_data = @buffer
    classindex = nil
    linenum = 1
    classline = 0
    first = false
    classcount = 0
    indent = false

    file_data.each_line do |line|
      unless line.index(tocheck).nil?
        indent = false
        if classcount == 1
          p "no indentation for #{tocheck} at line #{classline} in file #{@filename}"
          first = false
          classindex = nil
          classcount = 0
        end

        classindex = line.index(tocheck)
        classcount += 1
      end

      if !classindex.nil? && first == false
        classline = linenum
        first = true
      end
      if line.index('end') == classindex && !classindex.nil?

        first = false
        classindex = nil
        classcount -= 1
        indent = true
      end
      linenum += 1
    end
    p "no indentation for #{tocheck} at line #{classline} in file #{@filename}" if indent == false && classline != 0

    while @loopcount < 4
      @loopcount += 1
      case @loopcount
      when 1
        loop_indent('def')
      when 2
        loop_indent('while')
      when 3
        loop_indent('until')
      end
    end
  end

  private

  def count_methods(testbuffer = nil)
    @buffer = testbuffer if testbuffer
    words = @buffer.split(/\W+/)

    i = 0
    length = words.length
    count = 0
    while i < length
      count += 1 if words[i] == 'def'
      i += 1
    end
    count
  end

  def count_classes
    words = @buffer.split(/\W+/)
    i = 0
    length = words.length
    count = 0
    while i < length
      count += 1 if words[i] == 'class'
      i += 1
    end
    count
  end

  def count_modules
    words = @buffer.split(/\W+/)
    i = 0
    length = words.length
    count = 0
    while i < length
      count += 1 if words[i] == 'module'
      i += 1
    end
    count
  end
end
# rubocop: enable  Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/CyclomaticComplexity
