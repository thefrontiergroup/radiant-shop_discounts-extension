module ShopDiscounts
  module Models
    module Product
      
      def self.included(base)
        base.class_eval do
          after_create                  :assign_discounts
          
          # Assigns discounts based off categories discounts
          def assign_discounts
            category.discounts.each do |discount|      
              ShopDiscountable.create(:discount => discount, :discounted => self)
            end
          end
        end
      end
      
    end
  end
end