class ProductsController < Spree::BaseController
  layout 'application'
  
  resource_controller
  actions :show, :index 
    
  before_filter :find_cart
  
  index do
    before do
      @product_cols = 3
    end
  end
  
  def change_image
    @product = Product.find(params[:id])
    img = Image.find(params[:image_id])
    render :partial => 'image', :locals => {:image => img}
  end
  
  private
  
  def collection
    @collection ||= Product.find(:all, :page => {:start => 1, :size => 10, :current => params[:page]})
  end
end
