class User < ApplicationRecord
  has_many :videos, dependent: :destroy

  def create_digest
    self.digest = SecureRandom.hex
  end
end
