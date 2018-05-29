module SimpleActiveStorage
  mattr_accessor :default_url_options,default: {}
  def self.url_helpers
    Rails.application.routes.url_helpers
  end

  module Url
    extend ActiveSupport::Concern
    class UnknowObjectError < Exception; end
    def url(key = nil,options = {})
      options.reverse_merge! only_path: false
      options.reverse_merge! SimpleActiveStorage.default_url_options
      helpers = SimpleActiveStorage.url_helpers
      case self.class.name
        when "ActiveStorage::Blob"
          helpers.rails_blob_url(self,options)
        when "ActiveStorage::Attachment","ActiveStorage::Attached::One"
          helpers.rails_blob_url(self.blob,options)
        when "ActiveStorage::Variant","ActiveStorage::Preview"
          helpers.rails_representation_url(self,options)
        else
          raise UnknowObjectError.new("unknow object #{self}")
      end
    end

    def path(key = nil)
      url(key,only_path: true)
    end
  end
end
