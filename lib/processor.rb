class Processor

  def initialize(params = {})
      @unwantedChars = params.fetch(:unwantedChars, [])
  end

  def process(input)
    input.collect do |string|
      removeUnwantedChars(string)
      string
    end
  end

  private

  def removeUnwantedChars(string)
    @unwantedChars.each do |char|
      string.delete! char
    end
  end

end
