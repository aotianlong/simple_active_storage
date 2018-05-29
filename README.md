# SimpleActiveStorage
发现ActiveStorage在模型里面获取url非常不方便，想写一个容易的
比如
```ruby
user.avatar.variant("100x100")
```
每次都要写100x100多不方便
我们是不是可以这样写
```ruby
user.avatar.variant(:thumb)
```
这样是不是更简单一些
url也很不方便，每次都需要url_for才能获取到
我们是不是能
```ruby
user.avatar.path
user.avatar.url
```
这样更简单一点呢

## Usage
config/initializers/simple_active_storage.rb
```ruby
SimpleActiveStorage.default_url_options = {host: "www.example.com"}
SimpleActiveStorage.transformation :thumb do
  {resize: "100x100"}
end
SimpleActiveStorage.transformation :tiny do
  {resize: "20x20"}
end
SimpleActiveStorage.transformation :medium do
  {resize: "400x400"}
end
```

app/models/user.rb
```ruby
class User < ApplicationRecord
  has_one_attached  :avatar
  has_many_attached :photos
end

user = User.first
user.avatar.attach io: File.new(Rails.root.join("test","fixtures","files","test.png")),filename: "test.png"
user.photos.attach io: File.new(Rails.root.join("test","fixtures","files","test.png")),filename: "test.png"
user.avatar.path # => "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"
user.avatar.url  # => "http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/test.png"
user.avatar.variant(:thumb).path # => "http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpRERFd01IZ3hNREFHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--20ae94033d7a10dcb862bd24c1dcbb3740e61e7c/test.png"
user.avatar.variant(:thumb).url  # => "http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08f03241905408289698b118698ca7642c3e691e/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpRERFd01IZ3hNREFHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--20ae94033d7a10dcb862bd24c1dcbb3740e61e7c/test.png"
photo = user.photos[0]
photo.variant(:thumb).url # =>"http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e81a87b1d919f371e6b665e2c01301cff6d16a26/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpRERFd01IZ3hNREFHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--20ae94033d7a10dcb862bd24c1dcbb3740e61e7c/test.png"
photo.url                 # => "http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e81a87b1d919f371e6b665e2c01301cff6d16a26/test.png"
photo.blob.url            # => "http://www.example.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e81a87b1d919f371e6b665e2c01301cff6d16a26/test.png"
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'simple_active_storage'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install simple_active_storage
```

## Contributing
visit http://www.github.com/aotianlong/simple_active_storage
pull requests are welcome.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
