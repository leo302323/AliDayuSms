module AliDayuSms
  extend self

  def redis_client
    @redis_client ||= Redis.new(self.configuration.redis_config || {})
  end

  def set_code(phone, expire_time, value = nil, length = 6)
    value ||= random_code(length)
    redis_client.set("AliDayuSms:#{self.configuration.app_key}:#{phone}:code", value, ex: expire_time)
    value
  end

  def get_code(phone)
    redis_client.get("AliDayuSms:#{self.configuration.app_key}:#{phone}:code")
  end

  def delete_code(phone)
    redis_client.del("AliDayuSms:#{self.configuration.app_key}:#{phone}:code")
  end

  private

  def random_code(length)
    SecureRandom.random_number(('9' * length).to_i).to_s.rjust(length, '0')
  end
end