class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

Refile.secret_key = '20752aafade361ca5808c29877c761f254a84a83e687f74661601f010b911a0e3ba7236159b6b221e650ff8de77ab541bf4be9822e74fb5cff69cd8d2b95575c'

  private

    def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :optional_id, :profile_image_id])
    end

end
