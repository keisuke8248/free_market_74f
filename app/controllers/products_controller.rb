class ProductsController < ApplicationController
  def index
    @category_parent = Category.where(ancestry: nil)
  end

  def show
  end

  def new
    @product = Product.new
    @product.images.new
    @category_parent = Category.roots
  end

  def create
    @product = Product.new(product_params)
    if @product.images.present?
      @product.save
      redirect_to root_path    
    else
      redirect_to  new_product_path
    end
  end

  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :category_id, :brand,:status, :cost, :size, :prefecture_id, :days, :price, :description, images_attributes: [:image]).merge(user_id: current_user.id)
  end
end
