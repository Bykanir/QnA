class OauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    oauth('GitHub')
  end

  def google_oauth2
    oauth('google_oauth2')
  end

  private

  def oauth(network)
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: network) if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end 
end