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
user.avatar.path(:thumb)
user.avatar.url(:thumb)
```
这样更简单一点呢

## Usage
```ruby
SimpleActiveStorage.register :thumb,"100x100"
SimpleActiveStorage.register :tiny, "20x20"
SimpleActiveStorage.register :medium,"400x400"

class User < ApplicationRecord
  has_one_attached :avatar
end

user = User.first
user.avatar.path # => /rails_storage/xxx/xxxx.jpg
user.avatar.url  # => https://www.example.com/rails_storage/xxx/xxxx.jpg
user.avatar.path(:thumb) # => /xxx
user.avatar.url(:thumb) # => /xxx
user.avatar.variant(:thumb) # equals user.avatar.variant("100x100")
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
