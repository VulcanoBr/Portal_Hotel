class Users::PasswordsController < Devise::PasswordsController

  before_action :check_user_role, only: [:new, :create, :edit, :update]

  private

  def check_user_role
    if params[:role] == 'admin'
      flash[:alert] = "Recuperação de senha não permitida para administradores."
      redirect_to new_user_session_path(role: 'admin')
    end
  end
end
