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

  context 'Edge Cases' do
    it 'does not return an empty / nil string' do
      test_data = ['_']
      result = []
      expect(processor.process(test_data)).to eq result
    end
  end

  context 'End to end tests' do
    it 'should return multiple strings if passed multiple convertable strings' do
      test_data = [
        'AAAc91%cWwWkLq$1ci3_848v3d__K',
        'ywXPlO6nNLSiS91___9awW5e43Rjl',
        'AWQimHabV1Eh£ZrGG7Ikn6hhHpFMu',
        'ntMeCQTNVq0Rr$2NtD6ZoSCx6fnEH',
        '3EoGwAStRdbMCcykP3QbCqUq6o75r',
        'l6H9FKzYe6e676h3we4N68PT9tg60'
      ]
      result = [
          'Ac91%cWwWkLq£1c',
          'ywXPlO6nNLSiS91',
          'AWQimHabV1Eh£Zr',
          'ntMeCQTNVq0Rr£2',
          '3EoGwAStRdbMCcy',
          'l6H9FKzYe6e676h'
      ]
      expect(processor.process(test_data)).to eq result
    end

    it 'should return string if passed 1 convertable strings and ignore incorrect strings' do
      test_data = [
        'AAAc91%cWwWkLq$1ci3_848v3d__K',
        '_',
        '_4',
        '4_',
        '',
        ''
      ]
      result = ['Ac91%cWwWkLq£1c']
      expect(processor.process(test_data)).to eq result
    end
  end
end
