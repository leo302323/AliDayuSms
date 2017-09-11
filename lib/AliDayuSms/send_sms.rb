require 'net/http'
require 'digest'
require 'json'
require 'securerandom'

module AliDayuSms
  extend self

  def send_code(phone, sms_template_code, sms_params = {}, length = 6, expire_in = 600)
    code = set_code(phone, expire_in, nil, length)
    send(phone, sms_template_code, sms_params.merge(code: code))
  end

  def send(phone, sms_template_code, sms_params, extend = nil)
    sign_params = {
        method: configuration.method_str,
        app_key: configuration.app_key,
        timestamp: Time.now.getlocal('+08:00').strftime('%F %T'),
        v: '2.0',
        sign_method: 'md5',
        sms_type: 'normal',
        sms_free_sign_name: configuration.sign_name,
        rec_num: phone,
        format: 'json',
        simplify: configuration.simplify,
        sms_template_code: sms_template_code,
        sms_param: sms_params.to_json,
        extend: extend,
        target_app_key: configuration.target_app_key,
        session: configuration.session,
        partner_id: configuration.partner_id
    }.reject { |_k, v| v.nil? }

    sp = sign_params.merge(sign: sign(sign_params))

    Net::HTTP.post_form(URI.parse(configuration.url), sp)
  end

  private

  def sign(params)
    Digest::MD5.hexdigest(wrap_with_secret(sorted_option_string(params))).upcase
  end

  def wrap_with_secret(s)
    secret = self.configuration.app_secret
    "#{secret}#{s}#{secret}"
  end

  def sorted_option_string(options)
    options.map { |k, v| "#{k}#{v}" }.sort.join
  end
end