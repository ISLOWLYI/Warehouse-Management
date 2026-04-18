class ProductsController < ApplicationController
  before_action :set_warehouse
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]
  skip_before_action :require_admin!, only: [:index, :show]

  def index
    @products = @warehouse.products
    
    if params[:category].present?
      @products = @products.where(category: params[:category])
    end
    
    if params[:status].present?
      @products = @products.where(status: params[:status])
    end
    
    case params[:sort]
    when "name_asc"
      @products = @products.order(name: :asc)
    when "name_desc"
      @products = @products.order(name: :desc)
    when "quantity_asc"
      @products = @products.order(quantity: :asc)
    when "quantity_desc"
      @products = @products.order(quantity: :desc)
    when "updated_at_asc"
      @products = @products.order(updated_at: :asc)
    else
      @products = @products.order(updated_at: :desc)
    end
  end

  def show
  end

  def new
    @product = @warehouse.products.new
  end

  def create
    @product = @warehouse.products.new(product_params)
    if @product.save
      flash[:notice] = "Товар успешно создан."
      redirect_to warehouse_product_path(@warehouse, @product)
    else
      flash.now[:alert] = "Ошибка при создании товара."
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Товар успешно обновлен."
      redirect_to warehouse_product_path(@warehouse, @product)
    else
      flash.now[:alert] = "Ошибка при обновлении товара."
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = "Товар удален."
    redirect_to warehouse_products_path(@warehouse)
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:warehouse_id])
    unless @warehouse.users.include?(current_user)
      flash[:alert] = "У вас нет доступа к этому складу."
      redirect_to warehouses_path
    end
  end

  def set_product
    @product = @warehouse.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:sku, :name, :category, :quantity, :location, :status)
  end
end