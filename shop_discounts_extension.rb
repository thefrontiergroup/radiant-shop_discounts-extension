# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ShopDiscountsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/shop_discounts"
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem
  #   config.after_initialize do
  #     run_something
  #   end
  # end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    
    tab "Shop" do
      add_item "Discounts",     "/admin/shop/discounts"
    end
    
    ShopLineItem.send :include, ShopDiscounts::Models::Discountable, ShopDiscounts::Models::Purchaseable
    
    ShopProduct.send :include, ShopDiscounts::Models::Discountable
    ShopOrder.send :include, ShopDiscounts::Models::Discountable
    
    ShopPackage.send :include, ShopDiscounts::Models::Discountable rescue nil
    
    Page.send :include, ShopDiscounts::Tags::Cart, ShopDiscounts::Tags::Item
    
  end
end
