class ShopDiscountsExtension < Radiant::Extension
  version YAML::load_file(File.join(File.dirname(__FILE__), 'VERSION'))
  description "Add Discounts to Radiant Shop"
  url "https://github.com/thefrontiergroup/radiant-shop_discounts-extension"
  
  extension_config do |config|
    config.gem 'radiant-shop-extension'
  end
  
  UserActionObserver.instance.send :add_observer!, ShopDiscount
  UserActionObserver.instance.send :add_observer!, ShopDiscountable
  
  def activate
    
    tab "Shop" do
      add_item "Discounts", "/admin/shop/discounts", :before => "Orders"
    end
    
    ShopLineItem.send :include, ShopDiscounts::Models::Discountable, ShopDiscounts::Models::Purchaseable
    
    ShopProduct.send  :include, ShopDiscounts::Models::Discountable, ShopDiscounts::Models::Product
    ShopOrder.send    :include, ShopDiscounts::Models::Discountable
    ShopCategory.send :include, ShopDiscounts::Models::Discountable
    User.send         :include, ShopDiscounts::Models::Discountable
    
    Page.send         :include, ShopDiscounts::Tags::Cart, ShopDiscounts::Tags::Item
    
    FormLineItem.send :include, ShopDiscounts::Models::FormLineItem
    
    ApplicationController.send :include, ShopDiscounts::Controllers::ApplicationController
    
    if defined?(ShopPackage)
      ShopPackage.send :include, ShopDiscounts::Models::Discountable
    end
    
  end
end
