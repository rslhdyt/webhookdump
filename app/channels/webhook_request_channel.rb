class WebhookRequestChannel < ApplicationCable::Channel
  def subscribed
    stream_from "webhook_request:#{params[:webhook_slug]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
