class ChargesController < ApplicationController

  def new
    cart = Cart.find(params[:id])
    unless cart.user == @current_user
      redirect_to root_path
    end
    @total = cart.cart_items.to_a.sum { | item | item.quantity * item.product.price }
  end

  def create
    # Amount in cents
    raise

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @total,
      :description => 'Rails Stripe customer',
      :currency    => 'aud'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
