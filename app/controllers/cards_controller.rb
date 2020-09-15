class CardsController < ApplicationController

  require "payjp"

  def show
    @user = User.find(current_user.id)
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: :new
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

  def new
    @user = User.find(current_user.id)
    card = Card.find_by(user_id: current_user.id)
    redirect_to action: :show if card.present?
  end

  def destroy
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: :new
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      redirect_to action: :new
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: :show
      else
        redirect_to action: :pay
      end
    end
  end
end
