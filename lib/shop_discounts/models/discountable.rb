module ShopDiscounts
  module Models
    module Discountable
      
      def self.included(base)
        base.class_eval do
          has_many  :discountables, :class_name => 'ShopDiscountable', :as => :discounted, :dependent => :destroy
          has_many  :discounts,     :class_name => 'ShopDiscount',     :through => :discountables
        end
      end
      
    end
  end
end
