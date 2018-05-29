module SimpleActiveStorage
  class TransformationNotFound < Exception; end

  mattr_accessor :transformations
  def self.transformation(name,transformation = nil,&block)
    self.transformations ||= {}
    if block_given?
      transformation = yield
    end
    transformations[name] = transformation
  end

  module Variation
    extend ActiveSupport::Concern
    def initialize(transformation)
      if transformation.is_a? Symbol
        transformation = SimpleActiveStorage.transformations[transformation]
        if transformation.nil?
          raise TransformationNotFound.new("transformation: #{transformation} not found, perhaps you forget define it?")
        end
      end
      super(transformation)
    end
  end

end
