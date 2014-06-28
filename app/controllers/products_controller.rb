class ProductsController < ApplicationController
  respond_to :html

  def index
    @products = Product.order("id DESC")
    @search = Product.search(params[:q])
    #respond_with(@search.result)
  end

  def search 
    #q = params[:q]
    #@products = Product.search(title_cont: q).result
    @search = Product.search(params[:q])
    @products = @search.result
 
  end  

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    #消費者不能購買 庫存數量為0的產品   
    if @product.quantity > 0
      if !current_cart.items.include?(@product)
        current_cart.add_product_to_cart(@product)
        flash[:notice] = "你已成功將 #{@product.title} 加入購物車"
      else
        flash[:warning] = "你的購物車內已有此物品"
      end
    else
      flash[:notice] = "產品 #{@product.title}庫存數量為0 您不能購買" 
    end
    redirect_to :back
  end


end
