module Spooky
  class Base
    attr_reader :id, :uuid, :slug, :meta_title, :meta_description, :created_at,
                :created_by, :updated_at, :updated_by

    def initialize(attrs = {})
      @id = attrs["id"]
      @uuid = attrs["uuid"]
      @slug = attrs["slug"]
      @meta_title = attrs["meta_title"]
      @meta_description = attrs["meta_description"]
      @created_at = attrs["created_at"]
      @created_by = attrs["created_by"]
      @updated_at = attrs["updated_at"]
      @updated_by = attrs["updated_by"]
    end
  end
end
