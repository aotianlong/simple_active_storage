# SimpleActiveStorage
*first of all,I need to apologize for my pool english.*

when you using active storage
there are some inconvenient things, such as you get the url of attachment:
```ruby
user.avatar.variant(resize: "100x100")
```

you need repeat `resize: "100x100"` every time.


I need a short cut to replace `resize: "100x100"`, like this:

```ruby
user.avatar.variant(:thumb)
user.avatar.path
user.avatar.url
```

SimpleActiveStorage is do such thing.

## Usage

generate config file:
rails g simple_active_storage
it will generate a file located at: config/initializers/simple_active_storage.rb
content look like this:

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


### direct upload
when use activestorage direct upload
activestorage.js will make an ajax post to /rails/active_storage/direct_uploads
and return json data it looks like below:

```javascript
{
    "id": 4,
    "key": "veeUd2b2toSbym6DmZ2pLkoZ",
    "filename": "avatar.jpg",
    "content_type": "image/jpeg",
    "metadata": {},
    "byte_size": 145516,
    "checksum": "/uNyp1jXJPXLBD6X0XZn7g==",
    "created_at": "2018-05-29T16:50:51.801Z",
    "signed_id": "eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--578572a7c2d5925ac32622a7d7b832f68c536f51",
    "direct_upload": {
        "url": "http://localhost:3001/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdDVG9JYTJWNVNTSWRkbVZsVldReVlqSjBiMU5pZVcwMlJHMWFNbkJNYTI5YUJqb0dSVlE2RVdOdmJuUmxiblJmZEhsd1pVa2lEMmx0WVdkbEwycHdaV2NHT3daVU9oTmpiMjUwWlc1MFgyeGxibWQwYUdrRGJEZ0NPZzFqYUdWamEzTjFiVWtpSFM5MVRubHdNV3BZU2xCWVRFSkVObGd3V0ZwdU4yYzlQUVk3QmxRPSIsImV4cCI6IjIwMTgtMDUtMjlUMTY6NTU6NTIuMTgxWiIsInB1ciI6ImJsb2JfdG9rZW4ifX0=--b2deb5a21ef8b7a2a08cf354052a65e640be6450",
        "headers": {
            "Content-Type": "image/jpeg"
        }
    },
    "transformations": {
        "thumb": "http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--578572a7c2d5925ac32622a7d7b832f68c536f51/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpRERFd01IZ3hNREFHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--20ae94033d7a10dcb862bd24c1dcbb3740e61e7c/avatar.jpg",
        "tiny": "http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--578572a7c2d5925ac32622a7d7b832f68c536f51/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpQ2pJd2VESXdCam9HUlZRPSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--c8fb6fe35e8d91c55a9323e9858130607ecdb1bf/avatar.jpg",
        "medium": "http://www.example.com/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--578572a7c2d5925ac32622a7d7b832f68c536f51/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld1k2QzNKbGMybDZaVWtpRERRd01IZzBNREFHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b87eb27c4abc3f9bd937642f2e5809bfd553edf8/avatar.jpg"
    }
}
```

originally there is no transformations field in json data.
the transformations field data is provide by SimpleActiveStorage.

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
