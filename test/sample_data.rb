##################################################
# test_data.rb
#
# Test modules and classes for the 'use' package.
##################################################
module ModA
   def meth_a
      "ModA#meth_a"
   end

   def meth_b
      "ModA#meth_b"
   end

   def meth_c
      "ModA#meth_c"
   end
end

module ModB
   include ModA
   def meth_a
      "ModB#meth_a"
   end

   def meth_b
      "ModB#meth_b"
   end
end

module ModC
   def meth_x
      "ModC#meth_x"
   end

   def meth_y
      "ModC#meth_y"
   end

   def meth_z
      "ModC#meth_z"
   end
end

module ModD
   def meth_a
      "ModD#meth_a"
   end

   def meth_b
      "ModD#meth_b"
   end
end

class ClassA
   use ModA, :meth_a
end

class ClassB
   use ModB, :include => :meth_c, :alias => {:meth_b => :meth_z}
end

class ClassC
   use ModA, :exclude => [:meth_b, :meth_c]
   use ModC

   def meth_c
      "ClassC#meth_c"
   end
end

class ClassD
   use ModA,
      :alias   => {:meth_a => :meth_x, :meth_c => :meth_z},
      :exclude => :meth_b
end

class ClassE
   use ModA, :meth_a
   use ModD, :meth_b
end
