require 'structured_warnings'

unless defined? MethodRedefinedWarning
  # Warning raised in $VERBOSE mode if a method is shadowed.
  class MethodRedefinedWarning < StructuredWarnings::Base; end
end

class Class
  # The version of the 'use' library
  USE_VERSION = '1.4.0'.freeze

  # Allows you to include mixins in a fine grained manner. Instead of
  # including all methods from a given module, you can can instead mixin
  # only those methods you want through a combination of the :include,
  # :exclude, and :alias options.
  #
  # Examples:
  #
  #  # Defines a 'bar' and 'baz' method
  #  module Alpha
  #    def bar
  #      puts 'hello'
  #    end
  #
  #    def baz
  #      puts 'world'
  #    end
  #  end
  #
  #  # Defines a 'bar', 'blah', and 'zap' methods
  #  module Beta
  #    def bar
  #      puts 'goodbye'
  #    end
  #
  #    def blah
  #      puts 'new york'
  #    end
  #
  #    def zap
  #      puts 'zap'
  #    end
  #  end
  #
  #  # From the Alpha module, only mixin the 'bar' method. From the Beta
  #  # module exclude the 'bar' and 'zap' methods.
  #  class Zap
  #    use Alpha, :bar
  #    use Beta, :exclude => [:bar, :zap]
  #  end
  #
  #  z = Zap.new
  #
  #  z.bar  # => "hello"
  #  z.baz  # => NoMethodError - wasn't mixed in
  #  z.zap  # => NoMethodError - wasn't mixed in
  #  z.blah # => "new york"
  #
  #  # Alias a method on the fly
  #  class MyKlass
  #    use Alpha, :alias => {:bar, :test}
  #  end
  #
  #  m = MyKlass.new
  #  m.test # => 'hello'
  #  m.bar  # => NoMethodError - was aliased to 'test'
  #
  #  If no options follow the module name this method is identical
  #  to a standard include.
  #--
  #  Designer's note: Most of the explicit .to_s calls on method lists are
  #  here to deal with the fact that Ruby 1.8 returns strings for method
  #  lists while Ruby 1.9 returns symbols. To ensure compatibility, and
  #  preserve my sanity, all method names are converted to strings.
  #
  def use(*args)
    excluded_methods = []
    included_methods = []
    aliased_methods  = []

    mod = args.shift.clone

    # If no arguments follow the module name, treat it as a standard include
    if args.empty?
      included_methods.concat(mod.instance_methods)
    end

    m = Module.new

    args.each{ |arg|
      if arg.kind_of?(Hash)
        arg.each{ |key, val|
          case key.to_s
            when 'include'
              if val.respond_to?(:each)
                val.each{ |element| included_methods << element.to_s }
              else
                included_methods << val.to_s
              end
            when 'exclude'
              if val.respond_to?(:each)
                val.each{ |element| excluded_methods << element.to_s }
              else
                excluded_methods << val.to_s
              end
            when 'alias'
              aliased_methods.push(val)
            else
              raise "invalid key '#{key}'"
          end
        }
      else
        included_methods.push(arg.to_s)
      end
    }

    unless included_methods.empty? || excluded_methods.empty?
      err = 'you cannot include and exclude in the same statement'
      raise ArgumentError, err
    end

    local_instance_methods = mod.instance_methods.map{ |e| e.to_s }

    excluded_methods.map!{ |e| e.to_s }

    # Remove excluded_methods methods
    unless excluded_methods.empty?
      (local_instance_methods & excluded_methods).each{ |meth|
        mod.module_eval{ remove_method(meth) }
      }
    end

    # Alias methods. All aliased methods are automatically included.
    aliased_methods.each{ |pair|
      pair.each{ |old_method, new_method|
        included_methods << new_method
        mod.module_eval{
          alias_method(new_method, old_method)
          remove_method(old_method) rescue nil
        }
      }
    }

    included_methods.map!{ |e| e.to_s }

    # Remove all methods not specifically included. The rescue was needed
    # for those cases where a module included another module. Also, don't
    # remove methods from classes that already exist unless specifically
    # included.
    unless included_methods.empty?
      self_instance_methods = self.instance_methods.map{ |e| e.to_s }
      (local_instance_methods - included_methods).each{ |meth|
        if self_instance_methods.include?(meth)
          if included_methods.include?(meth)
            mod.module_eval{ undef_method(meth) rescue nil }
          else
            mod.module_eval{ remove_method(meth) rescue nil }
          end
        else
          mod.module_eval{ undef_method(meth) rescue nil }
        end
      }
    end

    m.module_eval{ include mod }

    # Raise a warning if methods are shadowed (in $VERBOSE mode)
    if $VERBOSE
      local_instance_methods = instance_methods(true)
      m.instance_methods.each{ |meth|
        next unless local_instance_methods.include?(meth)
        msg = "method '#{meth}' aliased, shadows old '#{meth}'"
        warn MethodRedefinedWarning, msg
      }
    end

    include m
  end
end
