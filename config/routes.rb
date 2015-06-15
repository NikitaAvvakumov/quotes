Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
      constraints: APIConstraints.new(version: 1, default: true) do
      resources :quotes, only: [:show, :create]
      match 'quotes', to: 'quotes#preflight', via: :options
    end
  end
end
