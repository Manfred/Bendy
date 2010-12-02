module Plastic
  module Shape
    def shape(*args)
      if args[0].kind_of?(Hash)
        klass = Class.new
        attributes = args[0]
      else
        klass, attributes = args
      end
      attributes.each do |attribute, value|
        if value.kind_of?(Proc)
          klass.send(:define_method, attribute, &value)
        else
          klass.send(:define_method, attribute) do
            value
          end
        end
      end
      klass.new
    end
  end
end