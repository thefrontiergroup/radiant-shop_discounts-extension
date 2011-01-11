module ShopDiscounts
  module Models
    module CategoryDiscountable
      
      def self.included(base)
        base.class_eval do
          has_many  :discountables, :class_name => 'ShopDiscountableCategory', :foreign_key  => :discounted_id, :dependent => :destroy
          has_many  :discounts,     :class_name => 'ShopDiscount',             :through      => :discountables          
        end
      end
      
    end
  end
end