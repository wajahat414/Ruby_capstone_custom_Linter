require 'strscan'
class Lintermain
    attr_accessor :buffer
    attr_accessor :loopcount
    attr_accessor :methods
    def initialize (buffer)
        @buffer=buffer
        @loopcount=0
    end

    def printdata
        print @buffer
    end
    def countmethods
        words=@buffer.split(/\W+/)
        $i = 0
        $length = words.length
        $count=0
        while $i < $length do
            if (words[$i] == 'def')
                $count +=1
            end
            $i +=1
        end
        $count
    end
    def countclasses
        words=@buffer.split(/\W+/)
        $i = 0
        $length = words.length
        $count=0
        while $i < $length do
            if (words[$i] == 'class')
                $count +=1
            end
            $i +=1
        end
        $count
    end
    def countmodules
        words=@buffer.split(/\W+/)
        $i = 0
        $length = words.length
        $count=0
        while $i < $length do
            if (words[$i] == 'module')
                $count +=1
            end
            $i +=1
        end
        $count
    end
    def classIndent
        file_data=@buffer
        classindex=nil
        linenum=1
        classline=0
        first=false
        classcount=0
        indent=false
        
        file_data.each_line do |line|
            
            if(line.index('class')!=nil)
                indent=false
                if(classcount==1)
                    p "no indentation for class at line #{classline}"
                    first=false
                    classindex=nil
                    classcount=0
                    
                end

                classindex=line.index('class')
                classcount+=1
            end

            if classindex!=nil && first==false
                classline=linenum
                first=true
            end
            if(line.index('end')==classindex && classindex!=nil)
               
                first=false
                classindex=nil
                classcount-=1
                indent=true
            end
            linenum+=1

        end
        if(indent==false)
            p "no indentation for class at line #{classline}"
        end


        
    end
    def methodIndent
        file_data=@buffer
        classindex=nil
        linenum=1
        classline=0
        first=false
        classcount=0
        indent=false
        
        file_data.each_line do |line|
            
            if(line.index('def')!=nil)
                indent=false
                if(classcount==1)
                    p "no indentation for method at line #{classline}"
                    first=false
                    classindex=nil
                    classcount=0
                    
                end

                classindex=line.index('def')
                classcount+=1
            end

            if classindex!=nil && first==false
                classline=linenum
                first=true
            end
            if(line.index('end')==classindex && classindex!=nil)
               
                first=false
                classindex=nil
                classcount-=1
                indent=true
            end
            linenum+=1

        end
        if(indent==false)
            p "no indentation for method at line #{classline}"
        end


        
    end
    def loopIndent(tocheck=nil)
        file_data=@buffer
        classindex=nil
        linenum=1
        classline=0
        first=false
        classcount=0
        indent=false
        
        file_data.each_line do |line|
            
            if(line.index(tocheck)!=nil)
                indent=false
                if(classcount==1)
                    p "no indentation for #{tocheck} at line #{classline}"
                    first=false
                    classindex=nil
                    classcount=0
                    
                end

                classindex=line.index(tocheck)
                classcount+=1
            end

            if classindex!=nil && first==false
                classline=linenum
                first=true
            end
            if(line.index('end')==classindex && classindex!=nil)
               
                first=false
                classindex=nil
                classcount-=1
                indent=true
            end
            linenum+=1

        end
        if(indent==false)
            p "no indentation for #{tocheck} at line #{classline}"
        end
       
        while(@loopcount<4) do
            @loopcount+=1
            if(@loopcount==1)
                loopIndent('while')
            elsif (@loopcount==2)
                loopIndent('begin')
            elsif (@loopcount==3)
                loopIndent('until')
            end
        end


        
    end



    def classlines
        $count=0
        $line=0
        $def=1
        $meth=false
        $clas=false
        $limit=0
        $h={}
        p " "
        file_data=@buffer
        rem=file_data.gsub /^$\n/, ''
        file_data.each_line do |line|
            words=line.split(/\W+/)
            p line
            p words
            $i = 0
            $length = words.length
            $count=0
            while $i < $length do
                if (words[$i] == 'class')
                    $count +=1
                    $clas=true
                    $classname=words[$i+1]
                    p $classname
                end
                if(words[$i] == 'def')
                    $def+=2
                    $meth=true
                end
                if(words[$i] == 'end' && $def==1)
                    $h.store($classname,$line)
                    p $h
                    $clas=false
                    $line=0
                end
                if(words[$i] == 'end' && $meth==true)
                    $def-=2
                    $meth=false
                end
                $i +=1
            end
            if($clas==true)
                $line+=1
            end
            p $line
            p $def
        end
        p "line="
        p $line
        name="tictac"
        value=0
        print $h
    end
    def processFiles
        filenames = Dir.glob("sample/*.rb")
        numberofFIles = filenames.length
    end
end


#!/usr/bin/env ruby
filenames = Dir.glob("sample/*.rb")
numberofFIles = filenames.length
file = File.open("#{filenames[0]}")
file_data = file.read

s = StringScanner.new(file_data)
# while(s.eos? == false) do
#     p s.scan(/\w+/) 
# end
#print count
# words=file_data.split(/\W+/)
# $i = 0
# $length = words.length
# $count=0

# while $i < $length do
#     p words[$i] 

#    if (words[$i] == 'def')
#     $count +=1
#    end

#    $i +=1
# end

x=Lintermain.new(file_data)

x.loopIndent('if')