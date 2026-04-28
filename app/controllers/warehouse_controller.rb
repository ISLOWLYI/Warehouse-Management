class WarehouseController < ApplicationController
  before_action :authenticate_user!

  def info
    redirect_to warehouses_path
  end
end
