class Users::RegistrationsController < Devise::RegistrationsController

  before_action :check_user_role, only: [:new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permitir novos atributos no signup (registro)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # Permitir novos atributos na edição de conta
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def check_user_role
    if params[:role] == 'admin'
      flash[:alert] = "Registro não permitido para administradores."
      redirect_to new_user_session_path(role: 'admin')
    end
  end
end
