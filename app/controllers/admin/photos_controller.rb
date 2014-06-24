class Admin::PhotosController < ApplicationController
  def new 
    @photo = Photo.new
  end 
    
  def create 
    #inding.pry 
    @photo = Photo.new(photo_params)
    # Photo.new(:image => params[:photo][:image]) => 這樣是ok的
    # Photo.new(image: params[:photo][:image]) = > 也ok
    @photo.save
    p = Product.find(params[:photo][:product_id])
    p.add_photo_to_product(@photo)  
    p.save
    redirect_to admin_products_path
  end  

  def destroy 
    @photo = Photo.find(params[:photo_id])
    @photo.destroy
    redirect_to admin_products_path
  end  

  private
    def photo_params
      params.require(:photo).permit(:image)
    end



end
