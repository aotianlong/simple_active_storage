require 'test_helper'
require 'generators/simple_active_storage/simple_active_storage_generator'

class SimpleActiveStorageGeneratorTest < Rails::Generators::TestCase
  tests SimpleActiveStorageGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
