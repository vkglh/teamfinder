Rails.application.routes.draw do
  default_url_options Rails.application.config.action_controller.default_url_options

  match '/:action' => 'home', via: [:get, :post]
  match '/:controller/:action', via: [:get, :post]

  root to: 'home#index'
end
