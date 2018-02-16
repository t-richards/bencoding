# bencoding

Crystal library for the [Bencoding][bencoding-wiki] data serialization format

## What is bencoding?

Bencoding is a simple data serialization format used by the popular
[BitTorrent][bittorrent] P2P file sharing system.

It contains only four data types, namely:

  - byte strings
  - integers
  - lists
  - dictionaries

For more info see the [bencoding spec][bencoding-spec].

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  bencoding:
    github: t-richards/bencoding
```

## Usage

```crystal
require "bencoding"

# Decoding:
Bencoding.decode("d3:foo3:bar3:bazi42ee") # => {"foo" => "bar", "baz" => 42}

# Encoding:
Bencoding.encode("foo bar") # => "7:foo bar"
Bencoding.encode(42) # => "i42e"
Bencoding.encode([1, 2, 3]) # => "li1ei2ei3ee"
Bencoding.encode({"foo" => 1, "bar" => -10}) # => "d3:bari-10e3:fooi1ee"
```

## Contributing

  1. Fork it ( https://github.com/t-richards/bencoding/fork )
  2. Create your feature branch (git checkout -b my-new-feature)
  3. Commit your changes (git commit -am 'Add some feature')
  4. Push to the branch (git push origin my-new-feature)
  5. Create a new Pull Request

## Contributors

  - [t-richards](https://github.com/t-richards) - Maintainer
  - [Hamdiakoguz](https://github.com/Hamdiakoguz) Hamdi Akoğuz - creator


[bencoding-wiki]: https://en.wikipedia.org/wiki/Bencode
[bencoding-spec]: http://www.bittorrent.org/beps/bep_0003.html#bencoding
[bittorrent]: http://www.bittorrent.org/
