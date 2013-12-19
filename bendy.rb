module Bendy
  module Shape
    def shape(*args)
      klass = args[0].kind_of?(Class) ? Class.new(args.shift) : Class.new
      methods = args[-1].kind_of?(Hash) ? args.pop : {}
      methods.each do |attribute, value|
        proc = value.kind_of?(Proc) ? value : Proc.new { |*args| value }
        klass.send(:define_method, attribute, &proc)
      end
      klass.new(*args)
    end
  end
end
