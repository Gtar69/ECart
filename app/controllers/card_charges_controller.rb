class CardChargesController < ApplicationController

  before_action :authenticate_user!

  def create
    # 用Service Object
    #CardChargeService.new()
    @order = current_user.orders.find_by_token(params[:order_id])
    @amount = @order.total * 100 # in cents
   
    Stripe.api_key = Settings.stripe_secret_key

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
      )


    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @order.token ,
      :currency    => 'usd'
    )

    @order.set_payment_with!("credit_card")
    @order.make_payment! 
    # 信⽤用卡付款成功也要寄信通知
    OrderMailer.notify_order_placed(@order).deliver
    redirect_to order_path(@order.token), :notice => "成功完成付款"

    rescue Stripe::CardError => e
      flash[:error] = e.message
      render "orders/pay_with_credit_card"
  end

end