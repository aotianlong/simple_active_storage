# 假设单个图片为picture
# 多个图片为pictures
module SimpleActiveStorage
  module Attached
    module Many
      def attach(*attachables)
        record.try(:before_active_storage_attach,attachables)
        result = super(*attachables)
        record.try(:after_active_storage_attach,{name: name, attachments: attachments})
        result
      end
    end


    module One
      def attach(attachable)
        record.try(:before_active_storage_attach,attachable)
        result = super attachable
        record.try(:after_active_storage_attach,{name: name, attachment: attachment})
        result
      end
    end

  end
end

