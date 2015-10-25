class Message < ActiveRecord::Base
  attr_accessor :body
  attr_readonly :data
  validates_length_of :data, maximum: 16.kilobytes + 32
  validates_uniqueness_of :uuid
  before_validation :set_uuid

  def to_param
    uuid
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
