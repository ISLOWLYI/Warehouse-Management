class WarehouseUsersController < ApplicationController
  before_action :set_warehouse
  before_action :set_warehouse_user, only: [:update, :destroy, :deactivate, :update_role]
  before_action :require_admin!

  def index
    @warehouse_users = @warehouse.warehouse_users.includes(:user).order(created_at: :desc)
  end

  def invite
    email = params[:email]
    role = params[:role] || "worker"

    if email.blank?
      flash[:alert] = "Email обязателен."
      redirect_to warehouse_warehouse_users_path(@warehouse) and return
    end

    user = User.find_by(email: email)

    if user && @warehouse.users.include?(user)
      flash[:alert] = "Пользователь уже участник этого склада."
      redirect_to warehouse_warehouse_users_path(@warehouse) and return
    end

    warehouse_user = @warehouse.warehouse_users.new(
      role: role,
      active: false,
      user: user || User.new(email: email, password: SecureRandom.hex(12), name: email)
    )

    if warehouse_user.save
      # In production, send invitation email with token
      flash[:notice] = "Приглашение отправлено на #{email}. Токен: #{warehouse_user.invitation_token}"
    else
      flash[:alert] = "Ошибка при отправке приглашения: #{warehouse_user.errors.full_messages.join(', ')}"
    end

    redirect_to warehouse_warehouse_users_path(@warehouse)
  end

  def update
    if @warehouse_user.update(warehouse_user_params)
      flash[:notice] = "Права пользователя обновлены."
    else
      flash[:alert] = "Ошибка при обновлении прав."
    end
    redirect_to warehouse_warehouse_users_path(@warehouse)
  end

  def update_role
    if @warehouse_user.update(role: params[:role])
      flash[:notice] = "Роль обновлена."
    else
      flash[:alert] = "Ошибка при обновлении роли."
    end
    redirect_to warehouse_warehouse_users_path(@warehouse)
  end

  def deactivate
    @warehouse_user.update(active: false)
    flash[:notice] = "Пользователь деактивирован."
    redirect_to warehouse_warehouse_users_path(@warehouse)
  end

  def destroy
    @warehouse_user.destroy
    flash[:notice] = "Пользователь удален из склада."
    redirect_to warehouse_warehouse_users_path(@warehouse)
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:warehouse_id])
    unless @warehouse.users.include?(current_user)
      flash[:alert] = "У вас нет доступа к этому складу."
      redirect_to warehouses_path
    end
  end

  def set_warehouse_user
    @warehouse_user = @warehouse.warehouse_users.find(params[:id])
  end

  def warehouse_user_params
    params.require(:warehouse_user).permit(:role, :active)
  end
end