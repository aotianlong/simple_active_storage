module SimpleActiveStorage
  class Railtie < ::Rails::Railtie
    initializer "simple_active_storage" do
      ActiveStorage::Variation.send :prepend,SimpleActiveStorage::Variation
      ActiveStorage::Attached::One.send :include,SimpleActiveStorage::Url
      ActiveStorage::Attachment.send :include,SimpleActiveStorage::Url
      ActiveStorage::Variant.send :include,SimpleActiveStorage::Url
      ActiveStorage::Preview.send :include,SimpleActiveStorage::Url
      config.after_initialize do
        ActiveStorage::Blob.send :include,SimpleActiveStorage::Url
      end
    end

  end
end
