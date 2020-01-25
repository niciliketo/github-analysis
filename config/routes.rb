Rails.application.routes.draw do
  resources :repos do
    resources :pull_requests
  end
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',   
  }
  # TODO: static pages gem install high_voltage
  root to: "reports#new"
  resources :reports
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
