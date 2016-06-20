module Spooky
  class Tag < Spooky::Base
    attr_reader :name, :description, :image, :hidden, :parent, :post_count

    def initialize(attrs = {})
      @name = attrs["name"]
      @description = attrs["description"]
      @image = attrs["image"]
      @hidden = attrs["hidden"]
      @parent = attrs["parent"]
      @post_count = attrs.dig("count", "posts")

      super(attrs)
    end
  end
end
