require 'spec_helper'
require 'Processor'

describe Processor do
  unwantedChars = %w[_ 4]
  changeableChars = { '$' => '£' }
  stringLength = 15

  subject(:processor) { described_class.new(unwantedChars: unwantedChars, changeableChars: changeableChars, stringLength: stringLength) }

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

  context 'Contiguous Chars' do
    it 'can remove contiguous duplicate characters of Upper case' do
      test_data = ['AAA']
      result = ['A']
      expect(processor.process(test_data)).to eq result
    end

    it 'can remove contiguous duplicate characters of Lower case' do
      test_data = ['aaa']
      result = ['a']
      expect(processor.process(test_data)).to eq result
    end

    it 'can remove contiguous duplicate characters of Lower and Upper case' do
      test_data = ['aaaAAA']
      result = ['aA']
      expect(processor.process(test_data)).to eq result
    end

    it 'does not remove contiguous duplicate characters of alternating case' do
      test_data = ['aAa']
      result = ['aAa']
      expect(processor.process(test_data)).to eq result
    end
  end

  context 'String Length' do
    it 'can truncate a long string to 15 chars' do
      test_data = ['jhs@£$%^&  *yat6%RAIDTUGLASJD824  QW']
      result = ['jhs@£%^& *yat6%']
      expect(processor.process(test_data)).to eq result
    end

    it 'will not truncate a short string' do
      test_data = ['jhs@£']
      result = ['jhs@£']
      expect(processor.process(test_data)).to eq result
    end
  end
end
