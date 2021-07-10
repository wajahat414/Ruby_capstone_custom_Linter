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
      expect(x.count_methods(teststring)).to eql(2)
    end
  end
  describe '#count_classes' do
    it 'count the number of classes in a file for example in file sample1.rb' do
      expect(xglob.count_classes).to eql(2)
    end
  end

  describe '#count_modules' do
    it 'count the number of modules in a file for example in file sample1.rb  has a single module' do
      expect(xglob.count_modules).to eql(3)
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
  end
  describe '#module_warning' do
    it 'shows excessive number of modules in a file than allowed module per file' do
      expect(xglob.module_warning).to eql(1)
    end
  end
end
