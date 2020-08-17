class PurchaseController < ApplicationController

  require 'payjp'

  def show
    @destination = current_user.destination
    @product = Product.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to controller: :cards, action: :new
    elsif @product.buyer_id.present?
      redirect_to controller: :products, action: :show
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card_information = customer.cards.retrieve(card.card_id)
      card_brand = @card_information.brand
      case card_brand 
      when "Visa"
        @card_src = "visa.gif"
      when "MasterCard"
        @card_src = "master-card.png"
      when "JCB"
        @card_src = "jcb.gif"
      when "American Express"
        @card_src = "american-express.gif"
      when "Diners Club"
        @card_src = "diners-club.gif"
      when "Discover"
        @card_src = "discover.jpg"
      end
    end
  end

  def pay
    @product = Product.find(params[:id])
    seller_id = @product.seller_id
    buyer_id = @product.buyer_id
    if buyer_id.present?
      redirect_to action: :fail
    elsif seller_id == current_user.id
      redirect_to root_path
    else
      card = Card.find_by(user_id: current_user.id)
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      Payjp::Charge.create(
      amount: @product.price,
      customer: card.customer_id,
      currency: 'jpy',
      )
      @product.update(buyer_id: current_user.id)
      redirect_to action: :done
    end
  end

  def done
  end

  def fail
  end

  def card
  end

  def create
    @card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      redirect_to action: :card
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      if @card.update(customer_id: customer.id, card_id: customer.default_card)
        redirect_to action: :show
      else
        redirect_to action: :card
      end
    end
  end

end
