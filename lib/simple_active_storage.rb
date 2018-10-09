require "simple_active_storage/railtie"
require "simple_active_storage/variation"
require "simple_active_storage/url"
require "simple_active_storage/direct_uploads_controller"
require "simple_active_storage/attached"

module SimpleActiveStorage
  # Your code goes here...
  include ActiveSupport::Configurable
end


ActiveStorage::Attached::One.prepend  SimpleActiveStorage::Attached::One
ActiveStorage::Attached::Many.prepend SimpleActiveStorage::Attached::Many
