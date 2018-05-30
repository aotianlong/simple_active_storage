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

  def self.transformation_exists?(name)
    self.transformations.keys.include? name
  end

  module Variation
    extend ActiveSupport::Concern


    def initialize(transformation)
      if transformation.is_a? Symbol
        @transformation_name = transformation
        transformation = SimpleActiveStorage.transformations[transformation]
        if transformation.nil?
          raise TransformationNotFound.new("transformation: #{transformation} not found, perhaps you forget define it?")
        end
      end
      super(transformation)
    end

    def key
      if SimpleActiveStorage.config.enable_shortcut_url && @transformation_name
        @transformation_name.to_s
      else
        super
      end
    end
  end

end
