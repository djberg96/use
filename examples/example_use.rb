Dir.chdir("..") if File.basename(Dir.pwd) == "examples"
$LOAD_PATH.unshift(Dir.pwd + "/lib")

require "use"

module Mod_A
   def meth_a
      "hello"
   end
   def meth_b
      "world"
   end
end

module Mod_B
   def meth_a
      "goodbye"
   end
   def meth_b
      "new york"
   end
   def meth_c
      "adios"
   end
end

# Various ways to mixin methods using 'use'.  Note that I am intentionally
# putting multiple 'use' statements within the classes for the sake of brevity
# and demonstration.  In practice, you would not use more than one per module.
#
class Foo
   use Mod_A                     # include all methods from Mod_A
   use Mod_A, :meth_a            # or, include only meth_a from Mod_A
   use Mod_A, include => :meth_a # same as above
end

class Bar
   use Mod_B, :include => [:meth_b, :meth_c] # include only meth_a and meth_b
   use Mod_B, :exclude => :meth_c            # same net result as above
end

class Baz
   use Mod_A, :meth_a                        # mixin meth_a from Mod_A
   use Mod_B, :alias => {:meth_a, :meth_z}   # mixin meth_a from Mod_B, but as meth_z
end

# Alias every method from Mod_B, as well as mixin Mod_A's meth_b.
class Zap
   use Mod_B, :alias => {
      :meth_a => :meth_x,
      :meth_b => :meth_y,
      :meth_c => :meth_z
   }

   use Mod_A, :meth_b
end
