## 1.4.0 - 4-Feb-2019
* Change the license to Apache 2.0.
* The USE_VERSION constant is now frozen.
* Updated the structured_warnings dependency, and apply related changes.
* Updated the gemspec license and depedencies, and added metadata.
* Rakefile now assumes Rubygems 2 or later.
* This gem is now signed.

## 1.3.3 - 12-Oct-2014
* Rakefile, gemspec and README updates.
* Fixed an unused variable warning.

## 1.3.2 - 8-Oct-2009
* Updated and fixed gemspec.
* Added the :gem rake task.

## 1.3.1 - 31-Jul-2009
* Fixed a bug where identical methods from different modules were being
  inadvertently undefined.
* Updated the main rdoc example and fixed a typo in the README synopsis.

## 1.3.0 - 30-Jul-2009
* Compatibility fixes for Ruby 1.9.x
* Added structured_warnings as a dependency, and now emits a
  MethodRedefinedWarning in $VERBOSE mode if a method is redefined.
* Changed license to Artistic 2.0.
* Fixed a bug with regards to aliased methods (which you probably
  never noticed).

## 1.2.2 - 16-Sep-2008
* Fixed a bug where methods already defined prior to the inclusion
  of a module could be accidentally undefined.
* Added some inline documentation for the sake of RDoc.
* Renamed test/test_data.rb to test/sample_data.rb, since it's not an
  actual test file.
* Renamed test/tc_use.rb to test/test_use.rb to be more in line with what
  both Rake and Test::Unit (and the Ruby community in general) expect.
* Minor Rakefile update.

## 1.2.1 - 22-May-2007
* Added a Rakefile, with tasks for testing and installation.
* Removed the install.rb file. Installation is now handled by the 'rake
  install' and 'rake install_gem' tasks.
* Updated the MANIFEST and made it RDoc friendly.
* Minor updates to the README and test files.

## 1.2.0 - 24-Feb-2006
* Method is now redefined within Class instead of Module in order to make
  the ability to use 'include' and 'alias' more flexible and work more nicely
  together.
* Updated the test suite.

## 1.1.0 - 20-Jan-2006
* Using 'use' with no arguments is now the same as if you used 'include',
  i.e. all methods are mixed in.  Previously, this would not mixin any methods.
* Added finer control of mixed in methods by allowing the use of three keyword
  arguments - 'include', 'exclude' and 'alias'.  See the documentation for
  more details.
* Added more inline documentation.
* More tests and examples.

## 1.0.0 - 1-Aug-2005
* Initial release
