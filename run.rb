require './lib/Processor'

unwantedChars = %w[_ 4]
changeableChars = { '$' => '£' }
stringLength = 15

processor = Processor.new(unwantedChars: unwantedChars, changeableChars: changeableChars, stringLength: stringLength)
inputStrings = [
  'AAAc91%cWwWkLq$1ci3_848v3d__K',
  'ywXPl£031O6nNLSiS91___9awW5e43Rjl',
  'AW$$HabV1Eh£ZrGG7Ikn6hhHpFMu',
  'ntMe$£QTNVq0Rr$2NtD6ZoSCx6fnEH',
  '3ES_dbMCcykP3QbCqUq6o75r',
  'l644F34KzYe6e676h3we4N68PT9tg60'
]
puts ""
puts 'Input:'
puts inputStrings
puts ""
puts 'Output:'
puts processor.process(inputStrings)

inputStrings2 = [
  'FOO BAR',
  'Have you tried tuning it off and on again',
  'CTRL_ALT_DEL',
  'TNETENNBA',
  '42',
  '!@£$%^&*()_±_+}{"|":<>?',
  '🙂'
]

processor2 = Processor.new(unwantedChars: ['3','$','^','?','/'] , changeableChars: {'a' => 'f'}, stringLength: 9)
puts ""
puts 'Input:'
puts inputStrings2
puts ""
puts 'Output:'
puts processor2.process(inputStrings2)