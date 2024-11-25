class WebhookExpired < ApplicationException
  def initialize(msg = "Webhook expired", code = 'W101')
    super(msg, code)
  end
end