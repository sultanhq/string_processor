class Processor

  def initialize(params = {})
      @unwantedChars = params.fetch(:unwantedChars, [])
      @changeableChars = params.fetch(:changeableChars, {})
      @stringLength = params.fetch(:stringLength, 15)
  end

  def process(input)
    input.collect do |string|
      removeUnwantedChars(string)
      changeChars(string)
      removeContiguous(string)
      outputString = truncateString(string)
    end
  end

  private

  def removeUnwantedChars(string)
    @unwantedChars.each do |char|
      string.delete! char
    end
  end

  def changeChars(string)
    @changeableChars.each do |k, v|
      string.gsub!(k, v)
    end
  end

  def removeContiguous(string)
      string.squeeze!
  end

  def truncateString(string)
    if (string.length > @stringLength)
      string[0...@stringLength]
    else
      string
    end
  end
end
