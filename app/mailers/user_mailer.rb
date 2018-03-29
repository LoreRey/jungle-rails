class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_confirmation(order, user)
     @user = user
     @order = order
     mail(to: @user.email, subject: "Order #{@order.id} has been received")
  end
end

