class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    flash[:notice] =  @user.errors.full_messages.to_sentence if !@user.valid?
    sign_in_and_redirect @user
  end
end