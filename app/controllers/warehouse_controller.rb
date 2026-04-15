class WarehouseController < ApplicationController
  before_action :authenticate_user!
  
  def info
    @stock_items = ["Товар А - 100 шт", "Товар Б - 50 шт", "Товар В - 30 шт"]
  end
end