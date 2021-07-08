# rubocop: disable Style/GlobalVars,Metrics/ClassLength,Metrics/BlockLength,Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/CyclomaticComplexity

# Description/Explanation of Main class
class Lintermain
  attr_accessor :buffer, :loopcount, :methodlimit, :methodnamelimit, :classlimit, :modulelimit, :classnamelimit,
                :filename

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

  def countmethods(_testbuffer = nil)
    @buffer = _testbuffer if _testbuffer
    words = @buffer.split(/\W+/)

    $i = 0
    $length = words.length
    $count = 0
    while $i < $length
      $count += 1 if words[$i] == 'def'
      $i += 1
    end
    $count
  end

  def methodwarning
    methodcount = countmethods
    if methodcount > @methodlimit
      r = methodcount - @methodlimit
      p "There are #{r} excessive method in file #{@filename}"
    end
    r
  end

  def classwarning
    classcount = countclasses
    if classcount > @classlimit
      r = classcount - @classlimit
      p "There are #{r} excessive classes in file #{@filename}"
    end
    r
  end

  def modulewarning
    modulecount = countmodules
    if modulecount > @modulelimit
      r = modulecount - @modulelimit
      p "There are #{r} excessive modules in file #{@filename}"
    end
    r
  end

  def countclasses
    words = @buffer.split(/\W+/)
    $i = 0
    $length = words.length
    $count = 0
    while $i < $length
      $count += 1 if words[$i] == 'class'
      $i += 1
    end
    $count
  end

  def countmodules
    words = @buffer.split(/\W+/)
    $i = 0
    $length = words.length
    $count = 0
    while $i < $length
      $count += 1 if words[$i] == 'module'
      $i += 1
    end
    $count
  end

  def loopindent(tocheck = nil)
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
        loopindent('def')
      when 2
        loopindent('while')
      when 3
        loopindent('until')
      end
    end
  end

  def classlines
    $count = 0
    $line = 0
    $def = 1
    $meth = false
    $clas = false
    $limit = 0
    $h = {}
    p ' '
    file_data = @buffer
    file_data.each_line do |line|
      words = line.split(/\W+/)
      p line
      p words
      $i = 0
      $length = words.length
      $count = 0
      while $i < $length
        if words[$i] == 'class'
          $count += 1
          $clas = true
          $classname = words[$i + 1]
          p $classname
        end
        if words[$i] == 'def'
          $def += 2
          $meth = true
        end
        if words[$i] == 'end' && $def == 1
          $h.store($classname, $line)
          p $h
          $clas = false
          $line = 0
        end
        if words[$i] == 'end' && $meth == true
          $def -= 2
          $meth = false
        end
        $i += 1
      end
      $line += 1 if $clas == true
      p $line
      p $def
    end
    p 'line='
    p $line
    print $h
  end
end
# rubocop: enable Style/GlobalVars, Metrics/ClassLength,Metrics/BlockLength,Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/CyclomaticComplexity
