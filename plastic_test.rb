require 'test/unit'
require 'plastic'

class Test::Unit::TestCase
  def self.test(description, &block)
    define_method("test] #{description}", &block)
  end
end

class PlasticTest < Test::Unit::TestCase
  include Plastic::Shape
  
  test "responds to stubbed accessors" do
    assert_equal 42, shape(:length => 42).length
  end
end