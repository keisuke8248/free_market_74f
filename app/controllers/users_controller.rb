class UsersController < ApplicationController
  def index
    @user = User.find(current_user[:id])
  end

  def show
    @products = Product.all.order(id: "DESC")
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
