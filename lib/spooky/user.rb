module Spooky
  class User < Spooky::Base
    attr_reader :name, :image, :cover, :bio, :website, :status, :language,
                :last_login, :count

    def initialize(attrs = {})
      @name = attrs["name"]
      @image = attrs["image"]
      @cover = attrs["cover"]
      @bio = attrs["bio"]
      @website = attrs["website"]
      @status = attrs["status"]
      @language = attrs["language"]
      @last_login = DateTime.iso8601(attrs["last_login"])
      @count = attrs["count"]

      super(attrs)
    end
  end
end
