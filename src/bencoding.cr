require "./bencoding/**"

module Bencoding
  BYTE_ARRAY_DIVIDER = ':' #  58
  DICTIONARY_END     = 'e' # 101
  DICTIONARY_START   = 'd' # 100
  LIST_END           = 'e' # 101
  LIST_START         = 'l' # 108
  NUMBER_END         = 'e' # 101
  NUMBER_START       = 'i' # 105
end
