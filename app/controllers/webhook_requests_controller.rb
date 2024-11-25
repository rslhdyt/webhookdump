class WebhookRequestsController < ApplicationController
  before_action :get_webhook!
  before_action :get_webhook_request!

  def show
    # Webhook request details are shown via @webhook_request
  end

  def destroy
    @webhook_request.destroy
    
    redirect_to webhook_path(@webhook.slug), notice: 'Webhook request was successfully deleted.'
  end

  private

  def get_webhook!
    @webhook = Webhook.find_by!(slug: params[:slug])
  end

  def get_webhook_request!
    @webhook_request = @webhook.webhook_requests.find(params[:id])
  end
end
