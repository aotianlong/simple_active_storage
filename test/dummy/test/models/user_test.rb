require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "photos" do
    SimpleActiveStorage.config.enable_shortcut_url = false
    aotianlong = users(:aotianlong)
    aotianlong.photos.attach io: File.new(Rails.root.join("test","fixtures","files","test.png")),filename: "test.png"
    photo = aotianlong.photos[0]
    # ActiveStorage::Attachment
    assert_equal photo.class.name,"ActiveStorage::Attachment"
    assert_equal photo.path,"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"
    assert_equal photo.url,"http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"
    # ActiveStorage::Blob
    assert_equal photo.blob.path,"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"
    assert_equal photo.blob.url,"http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"
  end


  test "avatar" do
    SimpleActiveStorage.config.enable_shortcut_url = false
    aotianlong = users(:aotianlong)
    aotianlong.avatar.attach io: File.new(Rails.root.join("test","fixtures","files","test.png")),filename: "test.png"
    assert aotianlong.avatar.attached?

    variant = aotianlong.avatar.variant(:thumb)
    assert_equal variant.variation.transformations, {:combine_options=>{:resize=>"100x100"}}
    assert_raise SimpleActiveStorage::TransformationNotFound do
      variant = aotianlong.avatar.variant(:thumb_not_exists)
    end
    path = "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"
    url = "http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"

    # ActiveStorage::Variant
    assert_equal aotianlong.avatar.variant(:thumb).path,"/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpRERFd01IZ3hNREFHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--20ae94033d7a10dcb862bd24c1dcbb3740e61e7c/test.png"
    assert_equal aotianlong.avatar.variant(:thumb).url,"http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpRERFd01IZ3hNREFHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--20ae94033d7a10dcb862bd24c1dcbb3740e61e7c/test.png"
    # ActiveStorage::Attached::One
    assert_equal aotianlong.avatar.path,path
    assert_equal aotianlong.avatar.url,url
  end


  test "short cut url" do
    SimpleActiveStorage.config.enable_shortcut_url = true
    aotianlong = users(:aotianlong)
    aotianlong.avatar.attach io: File.new(Rails.root.join("test","fixtures","files","test.png")),filename: "test.png"
    assert_equal  aotianlong.avatar.variant("thumb").url,"http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/thumb/test.png"
    assert_equal  aotianlong.avatar.variant(:thumb).url,"http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/thumb/test.png"
  end

  test "remove duplicate blobs" do
    aotianlong = users(:aotianlong)
    aotianlong.avatar.attach io: File.new(Rails.root.join("test","fixtures","files","test.png")),filename: "test.png"
    aotianlong.photos.attach aotianlong.avatar.blob
    aotianlong.photos.attach aotianlong.avatar.blob
    assert_equal 1,aotianlong.photos.attachments.size
  end

end
