$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'minitest/unit'
require 'shoulda'
require 'mocha'

require File.dirname(__FILE__) + '/../lib/garb'

class MiniTest::Unit::TestCase
  include Shoulda::InstanceMethods
  extend Shoulda::ClassMethods
  include Shoulda::Assertions
  extend Shoulda::Macros
  include Shoulda::Helpers

  alias :assert_not_equal :refute_equal
  
  def read_fixture(filename)
    File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
  end
  
end

MiniTest::Unit.autorun