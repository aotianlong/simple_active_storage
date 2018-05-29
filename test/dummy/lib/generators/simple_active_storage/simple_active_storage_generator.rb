class SimpleActiveStorageGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def copy_initializer_file
    copy_file "simple_active_storage.rb","config/initializers/simple_active_storage.rb"
  end
end
