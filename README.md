## Notice
Please do not confuse "use" with "using". This library was written before
refinements existed in Ruby, and it is largely obviated by that feature now.
Consequently I have archived this repository as I don't see a compelling case
for its usage any longer.

## Description
The 'use' library allows you to selectively mixin methods from a given
module and alias them on the fly if desired.

## Prerequisites
structured_warnings 0.3.0 or later
   
## Installation

`gem install use`

## Synopsis
```ruby
require 'use'
 
module Foo
  def bar
    puts "hello"
  end
  def baz
    puts "world"
  end
end

module Test
  def bar
    puts "goodbye"
  end
  def blah
    puts "new york"
  end
end

class Zap
  use Foo, :bar
  use Test, :blah
end

z = Zap.new

z.bar  # => "hello"
z.blah # => "new york"
z.baz  # => NoMethodError
 
# Using the new keywords
class MyKlass
  use Foo, :alias => {:bar => :test}
end
 
m = MyKlass.new
m.test # => "hello"
m.bar  # => NoMethodError
```
   
## Constants
`USE_VERSION`

The version of this library. This is a string.
   
## Notes
In `$VERBOSE` mode this library will issue a `MethodRedefinedWarning` if you
shadow an existing method. See the documentation for structured_warnings
for more details.

## Acknowledgements
Thanks go to Ara Howard for providing the original solution and to
Mauricio Fernandez, whose blog I plagiarized (and with whom I communicated)
in order to implement fine-grained mixins.

## Known Bugs
Some versions of Ruby 1.9.x may emit a warning in verbose mode. This is a
bug in Ruby 1.9.x and can be ignored. I seriously hope you aren't using
Ruby 1.9 at this point.
   
If you find any bugs please log them on the project page at
https://github.com/djberg96/use

## See Also
mixology at https://github.com/dan-manges/mixology

## Future Plans
None. Please see the Notice at the top.

## License
Apache-2.0

## Copyright
(C) 2005-2019, Daniel J. Berger
All Rights Reserved

## Author
Daniel J. Berger
