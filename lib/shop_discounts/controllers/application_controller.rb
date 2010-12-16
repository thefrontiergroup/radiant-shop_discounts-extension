module ShopDiscounts
  module Controllers
    module ApplicationController
      
      def self.included(base)
        base.class_eval do
          
          def find_or_create_shop_order_with_apply_cart_discount
            order = find_or_create_shop_order_without_apply_cart_discount
            
            if current_user
              current_user.discountables.each do |discountable|
                order.discountables.create(:discount_id => discountable.discount.id, :discounted_type => order.class.name)
              end
            end
              
          end
          alias_method_chain :find_or_create_shop_order, :apply_cart_discount
        end
      end
      
    end
  end
end