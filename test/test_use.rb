#######################################################################
# test_use.rb
#
# Test cases for the 'use' package.  The relevant modules and classes
# are stored in the 'test_data.rb' file. This test should be run via
# the 'rake test' task.
#######################################################################
require 'use'
require 'sample_data'
require 'test/unit'

class TC_Use < Test::Unit::TestCase
   def setup
      @a = ClassA.new
      @b = ClassB.new
      @c = ClassC.new
      @d = ClassD.new
      @e = ClassE.new
   end

   # Convert symbols to strings for 1.9.x
   def assert_methods(array, methods)
      methods = methods.map{ |m| m.to_s } 
      assert_equal(array, methods)
   end

   def test_version
      assert_equal('1.3.3', Class::USE_VERSION)
   end

   def test_mod_a_methods
      assert_methods(['meth_a', 'meth_b', 'meth_c'], ModA.instance_methods.sort)
   end

   def test_mod_b_methods
      assert_methods(['meth_a', 'meth_b', 'meth_c'], ModB.instance_methods.sort)
   end

   def test_mod_c_methods
      assert_methods(['meth_x', 'meth_y', 'meth_z'], ModC.instance_methods.sort)
   end

   def test_mod_d_methods
      assert_methods(['meth_a', 'meth_b'], ModD.instance_methods.sort)
   end

   def test_class_a_methods
      assert_respond_to(@a, :meth_a)
      assert_equal('ModA#meth_a', @a.meth_a)
   end

   def test_class_a_expected_errors
      assert_raise(NoMethodError){ @a.meth_b }
      assert_raise(NoMethodError){ @a.meth_c }
   end

   def test_class_b_methods
      assert_respond_to(@b, :meth_c)
      assert_respond_to(@b, :meth_z)
      assert_equal('ModA#meth_c', @b.meth_c)
      assert_equal('ModB#meth_b', @b.meth_z)
   end

   def test_class_b_expected_errors
      assert_raise(NoMethodError){ @b.meth_a }
      assert_raise(NoMethodError){ @b.meth_b }
   end

   def test_class_c_methods
      assert_respond_to(@c, :meth_a)
      assert_respond_to(@c, :meth_c)
      assert_respond_to(@c, :meth_x)
      assert_respond_to(@c, :meth_y)
      assert_respond_to(@c, :meth_z)

      assert_equal('ModA#meth_a', @c.meth_a)
      assert_equal('ClassC#meth_c', @c.meth_c)
      assert_equal('ModC#meth_x', @c.meth_x)
      assert_equal('ModC#meth_y', @c.meth_y)
      assert_equal('ModC#meth_z', @c.meth_z)
   end

   def test_class_c_expected_errors
      assert_raise(NoMethodError){ @c.meth_b }
   end

   def test_class_d_methods
      assert_respond_to(@d, :meth_x)
      assert_respond_to(@d, :meth_z)

      assert_equal('ModA#meth_a', @d.meth_x)
      assert_equal('ModA#meth_c', @d.meth_z)
   end

   def test_class_d_expected_errors
      assert_raise(NoMethodError){ @d.meth_a }
      assert_raise(NoMethodError){ @d.meth_b }
      assert_raise(NoMethodError){ @d.meth_c }
   end

   def test_class_e_methods
      assert_respond_to(@e, :meth_a)
      assert_respond_to(@e, :meth_b)
   end

   def teardown
      @a = nil
      @b = nil
      @c = nil
      @d = nil
      @e = nil
   end
end
