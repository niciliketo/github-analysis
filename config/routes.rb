# frozen_string_literal: true

Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  resources :repos do
    resources :pull_requests
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
                     skip: [:sessions, :registrations]
  # TODO: static pages gem install high_voltage
  root to: 'static_pages#home'
  resources :reports
  resources :user_registrations
  as :user do
    delete '/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
