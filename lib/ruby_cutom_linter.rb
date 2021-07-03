class Lintermain
    attr_accessor :buffer
    attr_accessor :loopcount
    attr_accessor :methodlimit
    attr_accessor :methodnamelimit
    attr_accessor :classlimit
    attr_accessor :modulelimit
    attr_accessor :classnamelimit
    attr_accessor :filename
    def initialize (buffer,filename)
        @buffer=buffer
        @loopcount=0
        @methodlimit=3
        @classlimit=1
        @methodnamelimit=5
        @classnamelimit=5
        @filename=filename
        @modulelimit=2
    end
    def countmethods(testbuffer=nil)
        if(testbuffer!=nil)
            words=testbuffer.split(/\W+/)
        elsif
            words=@buffer.split(/\W+/)
        end
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
    def methodwarning
        methodcount=countmethods
        if(methodcount>@methodlimit)
            r=methodcount-@methodlimit
            p "There are #{r} excessive method in file #{@filename}"
        end
        r
    end
    def classwarning
        classcount=countclasses
        if(classcount>@classlimit)
            r=classcount-@classlimit
            p "There are #{r} excessive classes in file #{@filename}"
        end
        r
    end
    def modulewarning
        modulecount=countmodules
        if(modulecount>@modulelimit)
            r=modulecount-@modulelimit
            p "There are #{r} excessive modules in file #{@filename}"
        end
        r
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
                    p "no indentation for #{tocheck} at line #{classline} in file #{@filename}"
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
        if(indent==false && classline!=0)
            p "no indentation for #{tocheck} at line #{classline} in file #{@filename}"
        end
       
        while(@loopcount<4) do
            @loopcount+=1
            if(@loopcount==1)
                loopIndent('def')
            elsif (@loopcount==2)
                loopIndent('while')
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
