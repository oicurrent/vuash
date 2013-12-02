require 'openssl'

class Message < ActiveRecord::Base
  attr_accessor :body
  before_create :set_uuid

  def encrypt(secret)
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
  end

  private
  def set_uuid
    write_attribute :uuid, SecureRandom.uuid
  end

  def digest(string)
    OpenSSL::Digest::SHA256.digest(string)
  end
end
