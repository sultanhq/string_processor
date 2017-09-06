require 'spec_helper'
require 'Processor'

describe Processor do
  unwantedChars = %w[_ 4]
  changeableChars = { '$' => '£' }
  subject(:processor) { described_class.new(:unwantedChars => unwantedChars, :changeableChars => changeableChars) }

  context 'Unwanted Chars' do
    it "can remove any instances of '_'" do
      test_data = ['a_c']
      result = ['ac']
      expect(processor.process(test_data)).to eq result
    end

    it "can remove any instances of '4'" do
      test_data = ['a4c']
      result = ['ac']
      expect(processor.process(test_data)).to eq result
    end

    it "can remove any instances of '4' & '_'" do
      test_data = ['a4c_']
      result = ['ac']
      expect(processor.process(test_data)).to eq result
    end

    it 'does not remove any instances of other chars ( !@%^&*() )' do
      test_data = ['a4c_!@%^&*()']
      result = ['ac!@%^&*()']
      expect(processor.process(test_data)).to eq result
    end
  end

  context 'Changing of Chars' do
    it "can change any instances of '$' to '£'" do
      test_data = ['$105']
      result = ['£105']
      expect(processor.process(test_data)).to eq result
    end
  end
end
