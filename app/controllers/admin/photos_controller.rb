class Admin::PhotosController < ApplicationController
  # 
  def create 
    #binding.pry  
    @product = Product.find(params[:product_id])
    @photo = @product.photos.create(photo_params)
    @product.add_photo_to_product(@photo)
    redirect_to admin_products_path
  end  


  private 
    def photo_params
      params.require(:photo).permit(:image)
    end



end
