# Keep the Secret Token outside of git

class JsonWebToken
  SECRET_KEY = "REPLACE_SOME_SECRET_KEY".freeze

  def self.encode(payload, exp = 1.month.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
