module Spooky
  class Tag < Spooky::Base
    attr_reader :name, :description, :image, :hidden, :parent

    def initialize(attrs = {})
      @name = attrs["name"]
      @description = attrs["description"]
      @image = attrs["image"]
      @hidden = attrs["hidden"]
      @parent = attrs["parent"]

      super(attrs)
    end
  end
end
