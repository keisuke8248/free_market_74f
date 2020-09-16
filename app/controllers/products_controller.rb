class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :login_check, only: [:new, :edit, :update, :destroy]
  before_action :correct_product, only:[:edit, :update, :destroy]

  def index
    @category_parent = Category.where(ancestry: nil)
    @products = Product.all.order(id: "DESC")
    render :layout => nil
  end

  def show
    @favorite = Favorite.new
    @comment = Comment.new
    @commentALL = @product.comments
  end

  def new
    @product = Product.new
    @product.images.new
    @category_parent_array = ["---"]
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @product = Product.new(product_params)
    if @product.images.present? && @product.save 
      redirect_to root_path
    else
      redirect_to  new_product_path
    end
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end


  def edit
    @category_parent = Category.roots
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      redirect_to edit_product_path
    end
  end

  def destroy
    render :layout => nil
    unless @product.seller_id == current_user.id && @product.destroy
      redirect_to product_path(@product.id)
    end
  end

  def search
    @products = Product.search(params[:keyword])
    @search_name = params[:keyword]
    render :layout => nil
  end

  private

  def login_check
    unless user_signed_in?
      redirect_to new_user_path
    end
  end

  def correct_product
    @product = current_user.products.find_by(id: params[:id])
      unless @product
        redirect_to root_url
      end
  end

  def product_params
    params.require(:product).permit(:id, :buyer_id, :name, :category_id, :brand, :status, :cost, :size, :judgment, :prefecture_id, :days, :price, :description, :seller_id, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
