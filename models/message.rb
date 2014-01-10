require 'openssl'

class Message < ActiveRecord::Base
  attr_accessor :body, :secret
  before_create :set_uuid

  def encrypt
    self.secret = SecureRandom.hex(8)

    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt

    cipher.key = digest(secret)
    iv = cipher.random_iv

    write_attribute :data, iv + cipher.update(body) + cipher.final
  end

  def decrypt(secret)
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.decrypt

    cipher.iv = data.slice! 0x0, 0x10
    cipher.key = digest(secret)

    @body = cipher.update(data) + cipher.final
    @body.force_encoding("UTF-8")
  end

  private
  def set_uuid
    write_attribute :uuid, SecureRandom.hex(8)
  end

  def digest(string)
    OpenSSL::Digest::SHA256.digest(string)
  end
end
