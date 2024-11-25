Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  # Interface for viewing webhook details under 'v' prefix
  scope path: 'v', controller: 'webhooks' do
    get '/:slug', action: :show, as: :webhook
    delete '/:slug', action: :destroy

    resources :webhook_requests, only: [:show, :destroy], 
              path: '/:slug', 
              controller: 'webhook_requests'
  end

  # Main webhook endpoint - keeps URLs as clean as possible
  match '/:slug', to: 'webhooks#handler', via: :all, as: :webhook_handler
end
