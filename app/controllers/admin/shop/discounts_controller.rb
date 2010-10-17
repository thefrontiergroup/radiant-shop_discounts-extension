class Admin::Shop::DiscountsController < Admin::ResourceController
  
  model_class ShopDiscount

  before_filter :config_global
  before_filter :config_index,  :only => [ :index ]
  before_filter :config_new,    :only => [ :new, :create ]
  before_filter :config_edit,   :only => [ :edit, :update ]
  before_filter :assets_global, :except => [ :remove, :destroy ]
  before_filter :assets_edit,   :only => [ :edit, :update ]
  
  private
  
    def config_global
      @inputs   ||= []
      @meta     ||= []
      @buttons  ||= []
      @parts    ||= []
      @popups   ||= []
    end
    
    def config_index
      @buttons  << 'new_discount'
    end
    
    def config_new
      @inputs   << 'name'
      @inputs   << 'amount'
      @inputs   << 'code'
      
      @meta     << 'start'
      @meta     << 'finish'
    end
    
    def config_edit
      @buttons  << 'browse_categories'
      @buttons  << 'browse_products'
      
      @inputs   << 'name'
      @inputs   << 'amount'
      @inputs   << 'code'
      
      @meta     << 'start'
      @meta     << 'finish'
      
      @parts    << 'categories'
      @parts    << 'products'
      
      @popups   << 'browse_categories'
      @popups   << 'browse_products'
    end
    
    def assets_global
      include_stylesheet 'admin/extensions/shop/edit'
      include_stylesheet 'admin/extensions/shop/index'
    end
    
    def assets_edit
      include_javascript 'admin/extensions/shop/edit'
      include_javascript 'admin/extensions/shop/discounts/edit'
      include_stylesheet 'admin/extensions/shop/discounts/edit'
    end
    
end