class WebhooksController < ApplicationController

  before_action :get_webhook!

  skip_before_action :verify_authenticity_token, only: [:handler]

  def show
    @webhook_requests = @webhook.webhook_requests.order(id: :desc)
  end

  def handler
    webhook_request = @webhook.webhook_requests.create(
      url: request.url,
      ip: request.remote_ip,
      method: request.method,
      host: request.host,
      headers: request_headers,
      query_params: request.query_parameters.to_json,
      payload: request.body.read
    )

    WebhookRequestChannel.broadcast_to(
      @webhook.slug, 
      {
        id: webhook_request.id,
        webhook_slug: @webhook.slug,
        method: webhook_request.method,
        url: webhook_request.url,
        ip: webhook_request.ip,
        created_at: webhook_request.created_at
      }
    )

    render plain: 'Ok'
  end

  private

  def get_webhook!
    @webhook = Webhook.find_by!(slug: params[:slug])

    if @webhook.expired?
      raise WebhookExpired
    end
  end

  def request_headers
    ignore_headers = %w[
      action_dispatch rack raw_post_data 
      original_script_name query_string script_name
      server_software gateway_interface http_cookie
      query_string request_method path_info remote_addr
    ]

    filtered_headers = {}

    headers = request.headers.env.each do |k, v|
      # skip non-HTTP headers
      next unless (k.in?(ActionDispatch::Http::Headers::CGI_VARIABLES) || k =~ /^HTTP_/) 
      next if ignore_headers.any? { |h| k.downcase.include?(h.downcase) }

      key = k.sub(/^HTTP_/, '').split('_').map(&:capitalize).join('-')

      filtered_headers[key] = v
    end

    filtered_headers
  end  
end
