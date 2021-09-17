# frozen_string_literal: true

class HumanFileReader
  attr_accessor :filename

  def initialize(filename)
    @filename = filename
  end

  def read_file()
    File.read(filename)
  end
end

RSpec.describe "Playground" do

  context 'given the question' do
    context '[read file abc.txt using ruby]' do

      it "as a [human] it should load a file" do
        file = 'spec/playground.txt'
        file_content = File.read(file)
    
        # puts '-' * 70
        # puts file_content
        # puts '-' * 70
    
        expect(file_content).to eq('Some more words')
      end

      xit "as a [computer] it should load a file" do
      end

    end

    context '[using ruby, make a class called FileReader with a method that reads a file' do
    
      it "as a [human] it should create a class with a method that reads a file" do
        file = 'spec/playground.txt'
        reader = HumanFileReader.new(file)

        file_content = reader.read_file
    
        # puts '-' * 70
        # puts file_content
        # puts '-' * 70
    
        expect(file_content).to eq('Some more words')
      end

      xit "as a [computer] it should create a class with a method that reads a file" do
      end

    end
  
  end

end
