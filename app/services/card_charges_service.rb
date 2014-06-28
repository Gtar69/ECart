class CardChargeService

  def initialize(user, token, stripeToken)
    @order = user.orders.find_by_token(token)
    @amount = @order.total * 100 # in cents
    @current_user = user
    @stripeToken = stripeToken
  end 

  def card_charge!
    Stripe.api_key = Settings.stripe_secret_key

    customer = Stripe::Customer.create(
      :email => @current_user.email,
      :card  => @stripToken
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
    
  end  


end