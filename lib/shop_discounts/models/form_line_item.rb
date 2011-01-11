module ShopDiscounts
  module Models
    module FormLineItem
      
      def self.included(base)
        base.class_eval do
          
          def create_with_discounts
            @result = create_without_discounts
            
            @order.discountables.each do |discountable|
              discountable.create_shop_line_items
            end
            
            @result
          end
          alias_method_chain :create, :discounts
    
        end
      end
      
    end
  end
end