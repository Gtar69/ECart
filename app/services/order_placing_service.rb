class OrderPlacingService
  def initialize(cart,order)
    @order = order
    @cart = cart
  end
 
  def place_order!
    @order.build_item_cache_from_cart(@cart)
    @order.calculate_total!(@cart)
    # 創建完Order後 後台必須能寄一封信給客戶
    # 另外OrderMailer 是Class為何可以直接用method instead instantiate an object
    OrderMailer.notify_order_placed(@order).deliver
  end
end