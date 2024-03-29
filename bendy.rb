# frozen_string_literal: true

module Bendy
  module Inspect
    def self.prepended(base)
      base.send(:extend, Bendy::Inspect::ClassMethods)
    end

    def __inspect_methods
      if self.class.__config.nil?
        ''
      else
        out = ' '
        self.class.__config.each do |method, value|
          out << "#{method}:#{value.inspect}, "
        end
        out[0..-3]
      end
    end

    def inspect
      "#<Bendy::Shape#{__inspect_methods}>"
    end

    module ClassMethods
      attr_accessor :__config
    end
  end

  module Shape
    def shape(*args, **methods)
      klass = args[0].is_a?(Class) ? Class.new(args.shift) : Class.new
      klass.send(:prepend, Bendy::Inspect)
      klass.__config = methods
      methods.each do |attribute, value|
        proc = value.is_a?(Proc) ? value : proc { |*_args| value }
        klass.send(:define_method, attribute, &proc)
      end
      kwargs = args[-1].is_a?(Hash) ? args.pop : {}
      klass.new(*args, **kwargs)
    end
  end
end
