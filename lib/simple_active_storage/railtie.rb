module SimpleActiveStorage
  class Railtie < ::Rails::Railtie
    initializer "simple_active_storage" do
      ActiveSupport.on_load :active_storage_blob do

        ActiveStorage::Variation.send :prepend,SimpleActiveStorage::Variation
        ActiveStorage::Attached::One.send :include,SimpleActiveStorage::Url
        ActiveStorage::Attachment.send :include,SimpleActiveStorage::Url
        ActiveStorage::Variant.send :include,SimpleActiveStorage::Url
        ActiveStorage::Preview.send :include,SimpleActiveStorage::Url
        ActiveStorage::Blob.send :include,SimpleActiveStorage::Url

        ActiveStorage::DirectUploadsController.send :prepend,SimpleActiveStorage::DirectUploadsController


        old_wrap = ActiveStorage::Variation.method :wrap
        # redefine wrap
        ActiveStorage::Variation.define_singleton_method :wrap do |transformation|
          if SimpleActiveStorage.config.enable_shortcut_url && transformation.is_a?(String)
            if SimpleActiveStorage.transformation_exists? transformation.to_sym
              transformation = transformation.to_sym
            end
          end
          old_wrap.call(transformation)
        end

      end

    end

  end
end
