class Admin::OrdersController < ApplicationController

  def index
    # 為什麼Order.all 會出現原始的資料結構?
    @orders = Order.find_each

  end  

  def show
    @order =  current_user.orders.find_by_token(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end 

  # 客人已付款 商家執行發貨動作
  def ship  
    @order =  Order.all.find_by_token(params[:id])
    @order.ship!
    redirect_to admin_orders_path
  end   

  # 物流公司已送達物品於客戶手上 商家確認狀態為shipped
  def deliver
    @order =  Order.all.find_by_token(params[:id])
    @order.deliver!
    redirect_to admin_orders_path
  end  

  # 商家取消訂單
  def cancel
    @order =  Order.all.find_by_token(params[:id])
    @order.cancell_order!
    redirect_to admin_orders_path
  end
  
  # 商家退貨流程
  def return
    @order =  Order.all.find_by_token(params[:id])
    @order.return_good!
    redirect_to admin_orders_path
  end  


end
