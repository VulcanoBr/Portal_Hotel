class Users::SessionsController < Devise::SessionsController

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_role

  def new
    params[:role] ||= 'admin' if request.path.starts_with?('/admin')
    super
  end

  def create
    super
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path # Redireciona o admin para o painel de admin
    else
      stored_location_for(resource) || root_path  #root_path # Redireciona o cliente para a página inicial
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
  end

  def set_role
    params[:role] ||= 'client'
  end
end
