require "AliDayuSms/version"
require 'AliDayuSms/redis_client'
require 'AliDayuSms/send_sms'
require 'AliDayuSms/validation'
require 'redis'



module AliDayuSms
  # Your code goes here...
  class Configuration
    attr_accessor :app_key, :app_secret, :log_path, :sign_name,
                  :redis_config
    attr_reader :url, :method_str

    def initialize
      @url = 'http://gw.api.taobao.com/router/rest'
      @method_str = 'alibaba.aliqin.fc.sms.num.send'
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
