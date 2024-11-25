class Webhook < ApplicationRecord
  before_validation :set_slug

  validates :expired_at, presence: true

  has_many :webhook_requests, dependent: :destroy

  def expired?
    expired_at < Date.today
  end

  private

  def set_slug
    self.slug = SecureRandom.uuid
  end
end
