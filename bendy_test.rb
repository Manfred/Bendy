$:.unshift(File.expand_path('../', __FILE__))

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
  attr_reader :color
  
  def initialize(color=nil)
    @color = color
  end
  
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
    assert_equal 'moo', @object.moo
    assert_equal 'Appie', @object.name
    assert_equal 42, @object[42]
  end
  
  test "responds to stubbed accessors" do
    assert @object.respond_to?(:moo)
    assert @object.respond_to?(:name)
    assert @object.respond_to?(:[])
  end
end

class BendyShapeSubclassWithArgsTest < Test::Unit::TestCase
  include Bendy::Shape
  
  def setup
    @object = shape(Cow,
      'Green',
      :name => 'Appie',
      :length => 42
    )
  end
  
  test "passes arguments to the initializer" do
    assert_equal 'Green', @object.color
  end
end


class BendyShapeExceptionTest < Test::Unit::TestCase
  include Bendy::Shape
  
  test "tries to pass regular arguments" do
    assert_raises(ArgumentError) do
      shape('Green')
    end
  end
end
