class OrderPlacingService
  def initialize(cart,order)
    @order = order
    @cart = cart
  end
 
  def place_order!
    # 建立訂單過程
    @order.build_item_cache_from_cart(@cart)
    @order.calculate_total!(@cart)
    # using destroy! intead of clear! becasue cart is not a collection  
    @cart.destroy!
    # 另外OrderMailer 是Class為何可以直接用method instead instantiate an object
    OrderMailer.notify_order_placed(@order).deliver
  end
end