class ApiKey < ApplicationRecord
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
