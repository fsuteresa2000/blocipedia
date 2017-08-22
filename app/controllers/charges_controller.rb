class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
           key: "#{ Rails.configuration.stripe[:publishable_key] }",
           description: "Blocipedia Premium Subscription",
           amount: 15_00
       }
end

  def create
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => 15_00,
      :description => 'Blocipedia Premium Subscription',
      :currency    => 'usd'
    )

    current_user.update_attribute(:role, 1)

    flash[:notice] = "Thank you for your Premium Subscription."
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  end
