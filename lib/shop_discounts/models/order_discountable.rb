module ShopDiscounts
  module Models
    module OrderDiscountable
      
      def self.included(base)
        base.class_eval do
          has_many  :discountables, :class_name => 'ShopDiscountableOrder', :as => :discounted, :dependent => :destroy
          has_many  :discounts,     :class_name => 'ShopDiscount', :through      => :discountables
        end
      end
      
    end
  end
end
