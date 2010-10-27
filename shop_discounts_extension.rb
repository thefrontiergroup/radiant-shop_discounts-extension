# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ShopDiscountsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/shop_discounts"
  
  extension_config do |config|
    #config.gem 'radiant-shop-extension', :lib => false
  end
  
  UserActionObserver.instance.send :add_observer!, ShopDiscount
  UserActionObserver.instance.send :add_observer!, ShopDiscountable
  
  def activate
    
    tab "Shop" do
      add_item "Discounts",     "/admin/shop/discounts"
    end
    
    ShopLineItem.send :include, ShopDiscounts::Models::Discountable, ShopDiscounts::Models::Purchaseable
    
    ShopProduct.send  :include, ShopDiscounts::Models::Discountable, ShopDiscounts::Models::Product
    ShopOrder.send    :include, ShopDiscounts::Models::Discountable
    ShopCategory.send :include, ShopDiscounts::Models::Discountable
    
    Page.send :include, ShopDiscounts::Tags::Cart, ShopDiscounts::Tags::Item
    
  end
end
