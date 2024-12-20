class HomeController < ApplicationController
  def index
    webhook = Webhook.create(expired_at: 1.week.from_now)

    redirect_to webhook_path(webhook.slug)
  end
end
