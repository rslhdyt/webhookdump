module ExceptionsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from WebhookExpired do |e|
      render 'errors/webhook_expired', layout: 'error', status: 400, locals: { error: e }
    end
  end
end
