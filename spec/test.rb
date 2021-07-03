# rubocop: disable Layout/LineLength
require_relative '../lib/ruby_cutom_linter'
describe Lintermain do
  file = File.open("sample/sample1.rb")
  file_data = file.read
  xglob=Lintermain.new(file_data,"sample1.rb")
  describe '#countmethods' do
    it 'count the number of methods in the String' do
      teststring = " def playerturn(cell_num, turn)\n
      if cell_num >= 1 && cell_num <= 9 && board[cell_num - 1] == cell_numn\n
        board[cell_num - 1] = if turn.zero?\n
                                'X'\n
                              else\n
                                'O'\n
                              end\n
        return false\n
      end\n
      def playerturn(cell_num, turn)\n
        if cell_num >= 1 && cell_num <= 9 && board[cell_num - 1] == cell_num\n
          board[cell_num - 1] = if turn.zero?\n
                                  'X'\n
                                else\n
                                  'O'\n
                                end\n
          return false\n
        end\n"
        x=Lintermain.new("","")
      expect(x.countmethods(teststring)).to eql(2)
    end
  end
  describe '#countclasses' do
    it 'count the number of classes in a file for example in file sample1.rb' do
      expect(xglob.countclasses).to eql(2)
      
    end
  end

  describe '#countmodules' do
    it 'count the number of modules in a file for example in file sample1.rb  has a single module' do
      expect(xglob.countmodules).to eql(3)
      
    end
  end

  describe '#methodwarning' do
    it 'shows excessive number of methods in a file than allowed methods per file' do
    expect(xglob.methodwarning).to eql(3)
    end
    
  end
  describe '#classwarning' do
    it 'shows excessive number of classes in a file than allowed classes per file' do
    expect(xglob.classwarning).to eql(1)
    end
    
  end
  describe '#modulewarning' do
    it 'shows excessive number of modules in a file than allowed module per file' do
    expect(xglob.modulewarning).to eql(1)
    end
    
  end
  
  
end
# rubocop: enable Layout/LineLength
