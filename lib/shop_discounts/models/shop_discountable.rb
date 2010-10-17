module ShopDiscounts
  module Models
    module ShopDiscountable
      
      def self.included(base)
        base.class_eval do
          has_many  :discountables, :class_name => 'ShopDiscountable', :foreign_key  => :discounted_id
          has_many  :discounts,     :class_name => 'ShopDiscount',     :through      => :discountables
        end
      end
      
    end
  end
end