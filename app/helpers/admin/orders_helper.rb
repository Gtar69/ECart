module Admin::OrdersHelper

  def render_admin_order_link(order)
    link_to(order.token, order_path(order.token))
  end  

end
