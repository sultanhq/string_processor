require 'spec_helper'
require 'Processor'

describe Processor do
  unwantedChars = ['_']
  subject(:processor) { described_class.new(unwantedChars) }

  context 'Unwanted Chars' do
    it "can remove any instances of '_'" do
      test_data = ['a_c']
      result = ['ac']
      expect(processor.process(test_data)).to eq result
    end
  end
end
