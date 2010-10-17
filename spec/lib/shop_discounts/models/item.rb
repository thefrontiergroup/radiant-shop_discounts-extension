module Shop
  module Models
    module Page
      
      def self.included(base)
        base.class_eval do
          
          alias_method :price, :value
          
          def price
            value -= discounted
            
            # We never want to return a negative cost
            [0.00,value.to_f].max
          end
          
          def discounted
            (value * discount)
          end
          
          def discount
            discount = BigDecimal.new('0.00')
            discounts.map { |d| discount += d.amount }
            
            # Convert to a percentage
            discount * 0.01
          end
          
        end
      end
      
    end
  end
end