# Mojicon

Mojicon is a Ruby Gem designed to simplify text processing for Japanese characters. It provides a wide range of text transformation functionalities, including conversions between full-width and half-width characters, kana and hiragana, kanji numerals to Arabic numerals, Arabic numerals to kanji, and more. This Gem allows methods to be applied directly to string objects.

## Features

- Conversion between full-width and half-width characters
- Conversion between hiragana and katakana
- Conversion from kanji numerals to Arabic numerals and vice versa
- Conversion from old kanji to new kanji
- Flexible text processing through normalization and transformation

## Installation

Add the following line to your Gemfile:

```ruby
gem 'mojicon'
```

Then, install the Gem using Bundler:
  
```ruby
bundle install
```

Or, you can install the Gem directly:

```ruby
gem install mojicon
```

## Usage

With Mojicon, you can apply methods directly to string objects. For example:

```ruby
require 'mojicon'

str = "ｈｏｇｅ"
puts str.han_to_zen
# => "ｈｏｇｅ"
```

Available methods include:

- trim_space - Removes all full-width and half-width spaces from the string.
- zen_to_han - Converts full-width characters to half-width characters.
- han_to_zen - Converts half-width characters to full-width characters.
- kana_to_hira - Converts katakana to hiragana.
- hira_to_kana - Converts hiragana to katakana.
- kanji_to_arabic - Converts kanji numeral representations to Arabic numerals.
- arabic_to_kanji - Converts Arabic numerals to kanji numeral representations.

And many more.

## How to Contribute

1.Fork the repository.

2.Create a feature branch (`git checkout -b feature/fooBar`).

3.Commit your changes (`git commit -am 'Add some fooBar'`).

4.Push to the branch (`git push origin feature/fooBar`).

5.Create a new Pull Request.

## License

This project is licensed under the MIT License.