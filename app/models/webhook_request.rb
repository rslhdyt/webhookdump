class WebhookRequest < ApplicationRecord
  # Convert headers and query params to JSON before saving
  before_save :ensure_json_format

  belongs_to :webhook

  private

  def ensure_json_format
    self.headers = headers.to_json unless headers.is_a?(String)
    self.query_params = query_params.to_json unless query_params.is_a?(String)
  end
end
