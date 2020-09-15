class ProductsController < ApplicationController
  def index
    @category_parent = Category.where(ancestry: nil)
    @products = Product.all.order(id: "DESC")
    render :layout => nil
  end

  def show
    @product = Product.find(params[:id])
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
  end

  def update
  end

  def destroy
    render :layout => nil
    @product = Product.find(params[:id])
    unless @product.seller_id == current_user.id && @product.destroy
      redirect_to product_path(@product.id)
    end
  end

  def search
    @category_parent_array = ["---"]
    @category_parent_array = Category.where(ancestry: nil)

    if params[:q].present?
      @search = Product.ransack(search_params)
      @items = @search.result
    else
      params[:q] = { sorts: 'id desc' }
      @search = Product.ransack()
      @items = Product.all
    end
    @products = Product.search(params[:keyword])
    @search_name = params[:keyword]
    @search = Product.ransack(params[:q])
    render :layout => nil
  end

  def again_search
    if params[:q].present?
      @search = Product.ransack(search_params)
      @items = @search.result
    else
      params[:q] = { sorts: 'id desc' }
      @search = Product.ransack()
      @items = Product.all
    end
    @search = Product.ransack(params[:q]) #ransackの検索処理
    @search_products = @search.result(distinct: true) # 検索結果
    render :layout => nil
  end

  private
  def product_params
    params.require(:product).permit(:id, :buyer_id, :name, :category_id, :brand, :status, :cost, :size, :judgment, :prefecture_id, :days, :price, :description, :seller_id, images_attributes: [:image]).merge(seller_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(
        :sorts,
        :name_cont,
        :price_gteq,
        :price_lteq,
        category_id_in: []
      )
    end
  end
