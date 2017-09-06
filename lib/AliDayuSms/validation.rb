module AliDayuSms
  def self.validate_code(phone, code)
    get_code(phone) == code
  end
end