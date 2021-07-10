require_relative '../lib/ruby_cutom_linter'
describe Lintermain do
  file = File.open('test/sample1.txt')
  file_data = file.read
  xglob = Lintermain.new(file_data, 'sample1.txt')
  describe '#count_methods' do
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
      x = Lintermain.new('', '')

      c = x.send(:count_methods, teststring)
      expect(c).to eql(2)
    end
  end
  describe '#count_classes' do
    it 'count the number of classes in a file for example in file sample1.rb' do
      c = xglob.send(:count_classes)
      expect(c).to eql(2)
    end
  end

  describe '#count_modules' do
    it 'count the number of modules in a file for example in file sample1.rb  has a three modules' do
      c = xglob.send(:count_modules)
      expect(c).to eql(3)
      puts c
    end
    it 'As we know there are three modules so anything other than 3 is good for negative test case' do
      c = xglob.send(:count_modules)
      expect(c).not_to eql(4)
      puts c
    end
  end

  describe '#method_warning' do
    it 'shows excessive number of methods in a file than allowed methods per file' do
      expect(xglob.method_warning).to eql(2)
    end
  end
  describe '#class_warning' do
    it 'shows excessive number of classes in a file than allowed classes per file' do
      expect(xglob.class_warning).to eql(1)
    end
    it 'return value should be 1 so it should not equal to any value other than 1' do
      expect(xglob.class_warning).not_to eql(2)
    end
  end
  describe '#module_warning' do
    it 'shows excessive number of modules in a file than allowed module per file in our case it should be 1' do
      expect(xglob.module_warning).to eql(1)
    end
    it 'return value should be 1 so it should not equal to any value other than 1' do
      expect(xglob.module_warning).not_to eql(2)
    end
  end
end
