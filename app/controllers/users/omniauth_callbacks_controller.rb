# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_after_action :verify_authorized

    def github
      @user = User.from_omniauth(request.env['omniauth.auth'])
      flash[:notice] = @user.errors.full_messages.to_sentence unless @user.valid?
      sign_in_and_redirect @user
    end
  end
end
