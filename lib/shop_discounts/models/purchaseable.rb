module ShopDiscounts
  module Models
    module Purchaseable
      
      def self.included(base)
        base.class_eval do
          
          def discount
            discount = BigDecimal.new('0.00')
            discounts.map { |d| discount += d.amount }
            
            # Maximum discount is 100%
            discount = [discount,100.0].min
            
            # Convert to a percentage
            discount * 0.01
          end
          
          def discounted
            (value * discount)
          end
          
          alias_method :value, :price
          def price
            result = BigDecimal.new('0.00')
            result = value - discounted
          end
        end
      end
      
    end
  end
end