class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def require_admin!
    unless current_user&.admin?
      flash[:alert] = "Доступ запрещен. Требуются права администратора."
      redirect_to(root_path)
    end
  end

  def require_worker_or_admin!
    unless current_user&.admin? || current_user&.worker?
      flash[:alert] = "Доступ запрещен."
      redirect_to(root_path)
    end
  end

  def require_admin_or_supplier!
    unless current_user&.admin? || current_user&.supplier?
      flash[:alert] = "Доступ запрещен."
      redirect_to(root_path)
    end
  end
end
