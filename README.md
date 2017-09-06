# LDC Preliminary Developer Test

## Challenge

To TDD an application that would convert a collection of strings into a new collection of strings following a set convention.

Requirements
- Inputs:
  - Data is supplied as a collection of strings (I made the assumption that they are in the form of an array).
  - Each string in this data can be any length (I also made the presumption that a string could be of zero length: `""` ).

- Outputs:
  - Strings must not be nil or empty.
  - Strings must be a maximum length of 15 characters long and truncated if exceeding this limit.
  - Strings must not have contiguous duplicate characters in the same case.
  - Dollar signs ($) must be replaced with Pound signs (£).
  - Underscores (_) and the number 4 be removed from the strings.

## Solution

I TDD'd this product by working out what the order of the functions were, I concluded that the strings should be processed in the order of:

1. Remove unwanted character
2. Change characters
3. Remove contiguous characters
4. Truncate the string
5. Not return a string if it has become empty

I also used a hashed parameter style on the class to allow the user easy choice over how they would like the strings returned.

I chose to leave the unwanted/changing character in the object instantiation, but could have also set these in the defaults of the instance when it initializes, this I think is just a personal choice as it allows the user to chose what characters are removed/changed.

## Instructions

Clone this repository and navigate to directory and run `$ bundle install`

To run tests run `$ rspec`

To see an example run `$ ruby run.rb`

To use the processor:
```ruby
$ pry
[1] pry(main)> require './lib/processor.rb' # require the Class
=> true
[2] pry(main)> unwantedChars = %w[_ 4] # set the unwanted character (in an array)
=> ["_", "4"]
[3] pry(main)> changeableChars = { '$' => '£' } # set the characters to change (in a hash {'char from' => 'char to'})
=> {"$"=>"£"}
[4] pry(main)> stringLength = 15 # set the returning string length
=> 15
[5] pry(main)> inputStrings = [
[5] pry(main)*   'AAAc91%cWwWkLq$1ci3_848v3d__K',
[5] pry(main)* 'ywXPl£031O6nNLSiS91___9awW5e43Rjl',] # Your input strings (in an array)
=> ["AAAc91%cWwWkLq$1ci3_848v3d__K", "ywXPl£031O6nNLSiS91___9awW5e43Rjl"]
[6] pry(main)> processor = Processor.new(unwantedChars: unwantedChars, changeableChars: changeableChars, stringLength: stringLength) # Initailise the processor
=> #<Processor:0x007fa4180e7f68
 @changeableChars={"$"=>"£"},
 @stringLength=15,
 @unwantedChars=["_", "4"]>
[7] pry(main)> pry(main)> processor.process(inputStrings) # Go!
=> ["Ac91%cWwWkLq£1c", "ywXPl£031O6nNLS"] # your procesed strings are returned.:-)
```
### Gems used
- rspec

