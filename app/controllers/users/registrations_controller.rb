class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :check_invitation_token, only: [:new, :create]

  def new
    if params[:invitation_token].present?
      @invitation_token = params[:invitation_token]
      @warehouse_user = WarehouseUser.find_by(invitation_token: @invitation_token, active: false)
    end
    super
  end

  def create
    if params[:invitation_token].present?
      @warehouse_user = WarehouseUser.find_by(invitation_token: params[:invitation_token], active: false)
      if @warehouse_user.nil?
        flash[:alert] = "Недействительное или уже использованное приглашение."
        redirect_to new_user_session_path and return
      end
    else
      flash[:alert] = "Регистрация доступна только по приглашению."
      redirect_to new_user_session_path and return
    end

    build_resource(sign_up_params)
    resource.role = @warehouse_user.role

    if resource.save
      @warehouse_user.update(user: resource, active: true, invitation_token: nil)
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def check_invitation_token
    # Allow access to new action only with valid invitation token
    if action_name == "new" && params[:invitation_token].blank?
      @invitation_token = nil
    end
  end

  def after_sign_up_path_for(resource)
    warehouses_path
  end
end
