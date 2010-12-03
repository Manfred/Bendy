module Bendy
  module Shape
    def shape(*args)
      klass      = args[0].kind_of?(Hash) ? Class.new : args.shift
      attributes = args[0]
      attributes.each do |attribute, value|
        proc = value.kind_of?(Proc) ? value : lambda { value }
        klass.send(:define_method, attribute, &proc)
      end
      klass.new
    end
  end
end