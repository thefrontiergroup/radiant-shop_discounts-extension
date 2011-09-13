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
    
    ShopProduct.send  :include, ShopDiscounts::Models::Discountable, ShopDiscounts::Models::ShopProduct
    ShopOrder.send    :include, ShopDiscounts::Models::OrderDiscountable, ShopDiscounts::Models::ShopOrder
    ShopCategory.send :include, ShopDiscounts::Models::CategoryDiscountable
    User.send         :include, ShopDiscounts::Models::Discountable
    
    Page.send         :include, ShopDiscounts::Tags::Cart, ShopDiscounts::Tags::Item, ShopDiscounts::Tags::PossibleDiscounts
    
    FormLineItem.send :include, ShopDiscounts::Models::FormLineItem
  end
end
