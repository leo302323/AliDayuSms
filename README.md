# AliDayuSms

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/AliDayuSms`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'AliDayuSms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install AliDayuSms

## Usage

-  config/initializers/AliDayuSms.rb

```
AliDayuSms.configure do |c|
  c.app_key = '阿里大于APP key' #required
  c.app_secret = '阿里大于 app secret' # required
  c.sign_name = '阿里大于 签名' #required
  
  # 非必填配置参数
  c.partner_id = '' # 合作伙伴身份标识。
  c.target_app_key = '' # 被调用的目标AppKey，仅当被调用的API为第三方ISV提供时有效。
  c.session = 'session' #用户登录授权成功后，TOP颁发给应用的授权信息，详细介绍请点击这里。当此API的标签上注明：“需要授权”，则此参数必传；“不需要授权”，则此参数不需要传；“可选授权”，则此参数为可选。
  c.redis_config = {host: host, port: 6379, user: 'foo'} # 如果不设置，默认使用本地localhost：7379
end
```
- send code

```
# code length default 6, expire time default 600s

AliDayuSms.send_code(phonecode, sms_template_code, sms_params = {}, length = 6, expire_in = 600)

# send custom sms message

AliDayuSms.send(phone, sms_template_code, sms_params, extend = nil)

AliDayuSms.send('18604246156', 'SMS_2635330', {code: '111111'})

# get code sent to specific phone

AliDayuSms.get_code(phone)

```

```
# validate code for specific phone 
AliDayuSms.validate_code(phone, code) #return boolean

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/AliDayuSms. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AliDayuSms project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/AliDayuSms/blob/master/CODE_OF_CONDUCT.md).
