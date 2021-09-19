# frozen_string_literal: true

RSpec.describe DiffFolder do
  let(:instance) { described_class.new(folder1, folder2) }
  let(:folder1) { 'spec/samples/a' }
  let(:folder2) { 'spec/samples/b' }

  describe '#initialize' do
    context 'when given valid relative paths' do
      context '.folder1' do
        subject { instance.folder1 }
      
        it { is_expected.to eq(File.join(Dir.pwd, folder1 )) }
      end

      context '.folder2' do
        subject { instance.folder2 }
      
        it { is_expected.to eq(File.join(Dir.pwd, folder2 )) }
      end
    end
  end

  describe '#run' do
    before { instance.run }

    context 'scenario1' do
      context '.raw_output' do
        subject { instance.raw_output }

        fit {
          instance.debug
        }
      end
    end
  end

  # it 'display files' do
  #   puts 'blah'
  #   subject.run
  # end

  # context 'different fodlers' do
  #   let(:folder2) { 'b' }

  #   it 'display files' do
  #     puts 'blah'
  #     subject.run
  #   end
  
  # end
end
