class ChargesController < ApplicationController
  before_action :check_premium

  class Amount
    def self.default
      @amount = 15_00
    end
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Postopedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.role = :premium

    flash[:notice] = "Thanks for the upgrade to Premium Membership, #{current_user.email}! Feel free to pay me again."
    redirect_to wikis_path # or wherever

   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Postopedia Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def downgrade
    if check_premium
      current_user.role = :standard
    end
  end

private
def check_premium
  if current_user.role == :premium
    flash[:notice] = "You are already a premium member."
    redirect_to wikis_path
  end
end

end
