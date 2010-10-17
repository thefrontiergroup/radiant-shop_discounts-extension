class Admin::Shop::Discounts::DiscountablesController < Admin::ResourceController
  
  model_class ShopDiscountable
  
  def create
    error = 'Could not attach Discount.'
    begin
      @shop_discountable.attributes = {
        :discount_id     => params[:discount_id],
        :discounted_id   => params[:discounted_id],
        :discounted_type => params[:discounted_type]
      }
      @shop_discountable.save!
      
      discounted_type = @shop_discountable.discounted_type.gsub('Shop','').underscore
      
      respond_to do |format|
        format.js { render :partial => "admin/shop/discounts/edit/shared/#{discounted_type}", :locals => { discounted_type.to_sym => @shop_discountable } }
      end
    rescue
      respond_to do |format|
        format.js { render :text => error, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    error = 'Could not remove Discount.'
    begin
      discounted_type = @shop_discountable.discounted_type.gsub('Shop','').underscore
      
      @shop_discountable.destroy
      
      respond_to do |format|
        format.js { render :partial => "admin/shop/discounts/edit/shared/#{discounted_type}", :locals => { discounted_type.to_sym => @shop_discountable } }
      end
    rescue
      respond_to do |format|
        format.js { render :text => error, :status => :unprocessable_entity }
      end
    end
  end
  
end