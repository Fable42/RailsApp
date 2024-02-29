class ApplicationController < ActionController::Base
  before_action :new_permitted_parameters, if: :devise_controller?

  private

  def new_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :tag])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :tag])
  end
end
