module Spooky
  class Post < Spooky::Base
    attr_reader :title, :markdown, :html, :image, :featured, :page, :status,
                :language, :published_at, :published_by, :author, :url, :tags

    def initialize(attrs = {})
      @title = attrs["title"]
      @markdown = attrs["markdown"]
      @html = attrs["html"]
      @image = attrs["image"]
      @featured = attrs["featured"]
      @page = attrs["page"]
      @status = attrs["status"]
      @language = attrs["language"]
      publish_attrs(attrs)

      super(attrs)
    end

    # Instance methods.
    def display_title
      meta_title ? meta_title : title
    end

    private

    def publish_attrs(attrs)
      @published_at = DateTime.iso8601(attrs["published_at"])
      @published_by = attrs["published_by"]
      @url = attrs["url"]
      author = attrs["author"]
      @author = author.is_a?(Hash) ? Spooky::User.new(author) : author
      tags = attrs["tags"]
      @tags = tags && !tags.empty? ? tags.map { |t| Spooky::Tag.new(t) } : tags
    end
  end
end
