require 'test/unit'
require 'bendy'

class Test::Unit::TestCase
  def self.test(description, &block)
    define_method("test] #{description}", &block)
  end
end

class BendyShapeTest < Test::Unit::TestCase
  include Bendy::Shape
  
  def setup
    @object = shape(
      :name => 'Appie',
      :length => 42
    )
  end
  
  test "invokes stubbed accessors" do
    assert_equal 'Appie', @object.name
    assert_equal 42, @object.length
  end
  
  test "responds to stubbed accessors" do
    assert @object.respond_to?(:name)
    assert @object.respond_to?(:length)
  end
end

class Cow
  def moo
    'moo'
  end
end

class BendyShapeSubclassTest < Test::Unit::TestCase
  include Bendy::Shape
  
  def setup
    @object = shape(Cow,
      :name => 'Appie',
      :length => 42
    )
  end
  
  test "invokes stubbed accessors" do
    assert_equal 'Appie', @object.name
    assert_equal 42, @object.length
  end
  
  test "responds to stubbed accessors" do
    assert @object.respond_to?(:name)
    assert @object.respond_to?(:length)
  end
end

class BendyShapeLambdaTest < Test::Unit::TestCase
  include Bendy::Shape
  
  def setup
    @object = shape(Cow,
      :name => lambda { 'Appie' },
      :[] => lambda { |index| index }
    )
  end
  
  test "invokes stubbed accessors" do
    assert_equal 'Appie', @object.name
    assert_equal 42, @object[42]
  end
  
  test "responds to stubbed accessors" do
    assert @object.respond_to?(:name)
    assert @object.respond_to?(:[])
  end
end