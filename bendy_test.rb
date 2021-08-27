# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))

require 'minitest/autorun'
require 'bendy'

module Minitest
  class Test
    def self.test(description, &block)
      define_method("test_ #{description}", &block)
    end
  end
end

class BendyShapeTest < Minitest::Test
  include Bendy::Shape

  def setup
    @object = shape(
      name: 'Appie',
      length: 42
    )
  end

  test 'invokes stubbed accessors' do
    assert_equal 'Appie', @object.name
    assert_equal 42, @object.length
  end

  test 'responds to stubbed accessors' do
    assert @object.respond_to?(:name)
    assert @object.respond_to?(:length)
  end
end

class Cow
  attr_reader :color

  def initialize(color = nil)
    @color = color
  end

  def moo
    'moo'
  end
end

class Sheep
  attr_accessor :color

  def initialize(color:)
    @color = color
  end
end

class BendyShapeSubclassTest < Minitest::Test
  include Bendy::Shape

  def setup
    @object = shape(
      Cow,
      name: 'Appie',
      length: 42
    )
  end

  test 'invokes stubbed accessors' do
    assert_equal 'Appie', @object.name
    assert_equal 42, @object.length
  end

  test 'responds to stubbed accessors' do
    assert @object.respond_to?(:name)
    assert @object.respond_to?(:length)
  end
end

class BendyShapeLambdaTest < Minitest::Test
  include Bendy::Shape

  def setup
    @object = shape(
      Cow,
      name: -> { 'Appie' },
      :[] => ->(index) { index }
    )
  end

  test 'invokes stubbed accessors' do
    assert_equal 'moo', @object.moo
    assert_equal 'Appie', @object.name
    assert_equal 42, @object[42]
  end

  test 'responds to stubbed accessors' do
    assert @object.respond_to?(:moo)
    assert @object.respond_to?(:name)
    assert @object.respond_to?(:[])
  end
end

class BendyShapeSubclassWithArgsTest < Minitest::Test
  include Bendy::Shape

  def setup
    @object = shape(
      Cow,
      'Green',
      name: 'Appie',
      length: 42
    )
  end

  test 'passes arguments to the initializer' do
    assert_equal 'Green', @object.color
  end
end

class BendyShapeSubclassWithKwargsTest < Minitest::Test
  include Bendy::Shape

  def setup
    @object = shape(
      Sheep,
      { color: 'Yellow' },
      name: 'Beep',
      length: 42
    )
  end

  test 'passes arguments to the initializer' do
    assert_equal 'Yellow', @object.color
  end

  test 'defines methods on the shape' do
    assert_equal 'Beep', @object.name
    assert_equal 42, @object.length
  end
end

class BendyShapeExceptionTest < Minitest::Test
  include Bendy::Shape

  test 'tries to pass regular arguments' do
    assert_raises(ArgumentError) do
      shape('Green')
    end
  end
end
