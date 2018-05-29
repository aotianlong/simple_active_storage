module SimpleActiveStorage
  module DirectUploadsController
    extend ActiveSupport::Concern
    private
    def direct_upload_json(blob)
      data = super(blob)
      # add additional data
      transformations = {}
      SimpleActiveStorage.transformations.keys.each do |key|
        transformations[key] = blob.variant(key).url
      end
      data[:transformations] = transformations
      data
    end
  end
end
