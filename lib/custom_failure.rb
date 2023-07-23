# frozen_string_literal: true

# This class ensures we can handle a user who is not logged in, and redirect them
class CustomFailure < Devise::FailureApp
  def redirect_url
    new_user_registration_url
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
