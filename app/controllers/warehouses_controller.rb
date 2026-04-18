class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy, :map]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if user_signed_in?
      @warehouses = current_user.warehouses.includes(:warehouse_users)
    else
      @warehouses = []
    end
  end

  def show
    authorize_warehouse!
    @products = @warehouse.products.order(updated_at: :desc).limit(10)
    @members = @warehouse.warehouse_users.includes(:user)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      WarehouseUser.create!(user: current_user, warehouse: @warehouse, role: :admin, active: true)
      current_user.update!(role: :admin) unless current_user.admin?
      flash[:notice] = "Склад успешно создан."
      redirect_to @warehouse
    else
      flash.now[:alert] = "Ошибка при создании склада."
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize_warehouse!
  end

  def update
    authorize_warehouse!
    if @warehouse.update(warehouse_params)
      flash[:notice] = "Склад успешно обновлен."
      redirect_to @warehouse
    else
      flash.now[:alert] = "Ошибка при обновлении склада."
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize_warehouse!
    @warehouse.destroy
    flash[:notice] = "Склад удален."
    redirect_to warehouses_path
  end

  def map
    authorize_warehouse!
    @zones = @warehouse.zones_count.positive? ? @warehouse.zones_count : 1
    @racks = @warehouse.racks_count.positive? ? @warehouse.racks_count : 1
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :owner_name, :address, :area, :racks_count, :zones_count)
  end

  def authorize_warehouse!
    unless @warehouse.users.include?(current_user)
      flash[:alert] = "У вас нет доступа к этому складу."
      redirect_to warehouses_path
    end
  end
end