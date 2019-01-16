# 假设单个图片为picture
# 多个图片为pictures
module SimpleActiveStorage
  module Attached
    module Many
      # 检查过滤掉已经存在的
      def attach(*attachables)
        record.try(:before_active_storage_attach,attachables)

        # remove duplicate attachments
        signed_ids = attachments.map(&:signed_id)
        blobs = attachables.map{|attachable| create_blob_from attachable}.compact
        filtered_blobs = blobs.find_all{|blob|
          !signed_ids.include?(blob.signed_id)
        }

        result = super(*filtered_blobs)
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

