module Plastic
  module Shape
    def shape(attributes)
      object = Class.new
      attributes.each do |attribute, value|
        object.send(:define_method, attribute) do
          value
        end
      end
      object.new
    end
  end
end